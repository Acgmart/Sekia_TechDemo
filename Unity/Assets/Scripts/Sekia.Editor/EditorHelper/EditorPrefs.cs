using System.IO;
using System.Collections.Generic;

namespace Sekia
{
    /// <summary>
    /// 类似于<see cref="UnityEditor.EditorPrefs"/>
    /// 将数值保存到工程的Library Cache中
    /// </summary>
    public class EditorPrefs
    {
        #region 声明区
        private const string CACHE_PATH = "Library/_Cache_EditorPrefs";
        private static bool _inited = false;
        private static Prefs _Instance = new Prefs();

        public class Prefs
        {
            public Dictionary<string, bool> bool_values = new Dictionary<string, bool>();
        }

        private static void LoadCache()
        {
            if (_inited)
                return;
            _inited = true;

            if (File.Exists(CACHE_PATH))
            {
                string data = File.ReadAllText(CACHE_PATH);
                _Instance = MongoHelper.FromJson<Prefs>(data);
            }
            else
                SaveCache();
        }

        //每次Set并发生数值变动时执行
        private static void SaveCache()
        {
            string data = MongoHelper.ToJson(_Instance);
            File.WriteAllText(CACHE_PATH, data);
        }
        #endregion

        #region 接口区-Bool
        public static string _NeedLoadLayout = "_NeedLoadLayout";

        public static bool GetBool(string key, bool defaultValue)
        {
            LoadCache();
            if (_Instance.bool_values.ContainsKey(key))
                return _Instance.bool_values[key];
            SetBool(key, defaultValue);
            return defaultValue;
        }

        public static void SetBool(string key, bool value)
        {
            LoadCache();
            if (_Instance.bool_values.ContainsKey(key) &&
                _Instance.bool_values[key] == value)
                return;
            _Instance.bool_values[key] = value;
            SaveCache();
        }
        #endregion
    }
}
