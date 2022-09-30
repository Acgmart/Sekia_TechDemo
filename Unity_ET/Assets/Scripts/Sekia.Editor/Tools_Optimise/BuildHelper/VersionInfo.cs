using System.Collections.Generic;

namespace ET
{
    public class AssetInfo
    {
        public string MD5;
        public long Size;
    }

    public class VersionInfo//二进制读写用配置
    {
        public string Version = "1.0.0";

        public int TotalNumber = 0;

        public long TotalSize = 0;

        public SortedDictionary<string, AssetInfo> AssetInfoDict = new SortedDictionary<string, AssetInfo>();
    }
}
