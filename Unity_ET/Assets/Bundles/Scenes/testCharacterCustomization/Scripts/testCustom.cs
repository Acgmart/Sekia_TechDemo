using UnityEngine;
using FairyGUI;

public class testCustom : MonoBehaviour
{

    Custom_Model model = new Custom_Model();

    GComponent _mainView;

    void Awake()
    {
        Application.targetFrameRate = 30;
        Screen.SetResolution(1136, 640, false);

        Stage.inst.onKeyDown.Add(OnKeyDown);
        GameObject body = Resources.Load<GameObject>("Prefabs/body");
        GameObject head = Resources.Load<GameObject>("Prefabs/head");
        model.Load_Custom_Model(body, head, 5);

        //设置root(Custom)的初始位置
        model.root.transform.localScale = new Vector3(10F, 10F, 10F);
        model.root.transform.localEulerAngles = new Vector3(0F, 180F, 0F);
        model.root.transform.localPosition = new Vector3(4.33F, -21.28F, 10F);
    }

    void Start()
    {
        _mainView = this.GetComponent<UIPanel>().ui;
        _mainView.GetChild("BG").z = 1600F; //后移背景图

        //初始化捏人操作项
        int[] custom_ints = Custom_Model.custom_ints;
        for (int i = 0; i < custom_ints.Length / 2; ++i)
        {
            int custom_index = custom_ints[i * 2];
            GObject _gObject_slider = _mainView.GetChild("S_Set_" + custom_index.ToString());
            if (_gObject_slider != null)
            {
                GSlider _slider = _gObject_slider.asSlider;
                _slider.value = (double)custom_ints[i * 2 + 1];
                _slider.onChanged.Add(() => { model.Custom_Bone(custom_index, (int)_slider.value); });
            }
        }

        //初始化头发设置
        int[] hair_ints = Custom_Model.hair_ints;
        for (int i = 0; i < hair_ints.Length / 2; ++i)
        {
            int hair_part_index = hair_ints[i * 2];
            int hair_part_id = hair_ints[i * 2 + 1];
            GObject _gObject_list = _mainView.GetChild("L_Hair_" + hair_part_index.ToString());
            if (_gObject_list != null)
            {
                GList _gList = _gObject_list.asList;
                GComponent _item_Box = _gList.AddItemFromPool(UIPackage.GetItemURL("Custom", "Item_Box")).asCom;
                GList _item_list = _item_Box.GetChild("item_list").asList;
                _item_list.RemoveChildrenToPool();

                //加载全部头发缩略图
                if (hair_part_index == 0)
                {
                    Hair_Front_Kind[] _hair_front_kinds = SekiaHelp.Sekia_EnumToArray<Hair_Front_Kind>();
                    for (int n = 0; n < _hair_front_kinds.Length; n++)
                    {
                        GButton item = _item_list.AddItemFromPool().asButton; //向列表添加新子级
                        Hair_Front_Kind _hair_front_kind = _hair_front_kinds[n]; //lambda参数需要为固定值
                        string item_name = _hair_front_kind.ToString(); //enum名作为物品名
                        item.title = item_name;
                        item.icon = UIPackage.GetItemURL("Custom", "p_cf_hair_" + item_name);
                        item.onClick.Add(() =>
                        {
                            _item_Box.GetChild("item_name").asTextField.text = item_name;
                            _item_Box.GetChild("item_icon").asLoader.icon = item.icon;
                            model.Change_Hair_Front(_hair_front_kind);
                        });

                        if (n == hair_part_id)
                        {
                            item.onClick.Call(); //执行初始服装设置
                        }
                    }
                }
                else if (hair_part_index == 1)
                {
                    Hair_Back_Kind[] _hair_back_kinds = SekiaHelp.Sekia_EnumToArray<Hair_Back_Kind>();
                    for (int n = 0; n < _hair_back_kinds.Length; n++)
                    {
                        GButton item = _item_list.AddItemFromPool().asButton; //向列表添加新子级
                        Hair_Back_Kind _hair_back_kind = _hair_back_kinds[n]; //lambda参数需要为固定值
                        string item_name = _hair_back_kind.ToString(); //enum名作为物品名
                        item.title = item_name;
                        item.icon = UIPackage.GetItemURL("Custom", "p_cf_hair_" + item_name);
                        item.onClick.Add(() =>
                        {
                            _item_Box.GetChild("item_name").asTextField.text = item_name;
                            _item_Box.GetChild("item_icon").asLoader.icon = item.icon;
                            model.Change_Hair_Back(_hair_back_kind);
                        });

                        if (n == hair_part_id)
                        {
                            item.onClick.Call(); //执行初始服装设置
                        }
                    }
                }
                else if (hair_part_index == 2)
                {
                    Hair_Ahoge_Kind[] _hair_ahoge_kinds = SekiaHelp.Sekia_EnumToArray<Hair_Ahoge_Kind>();
                    for (int n = 0; n < _hair_ahoge_kinds.Length; n++)
                    {
                        GButton item = _item_list.AddItemFromPool().asButton; //向列表添加新子级
                        Hair_Ahoge_Kind _hair_ahoge_kind = _hair_ahoge_kinds[n]; //lambda参数需要为固定值
                        string item_name = _hair_ahoge_kind.ToString(); //enum名作为物品名
                        item.title = item_name;
                        item.icon = UIPackage.GetItemURL("Custom", "p_cf_hair_" + item_name);
                        item.onClick.Add(() =>
                        {
                            _item_Box.GetChild("item_name").asTextField.text = item_name;
                            _item_Box.GetChild("item_icon").asLoader.icon = item.icon;
                            model.Change_Hair_Ahoge(_hair_ahoge_kind);
                        });

                        if (n == hair_part_id)
                        {
                            item.onClick.Call(); //执行初始服装设置
                        }
                    }
                }
            }
        }

        //初始化服装设置
        int[] clothes_ints = Custom_Model.clothes_ints;
        for (int i = 0; i < clothes_ints.Length / 2; ++i)
        {
            int clothes_part_index = clothes_ints[i * 2]; //当前服装部件的类型
            int clothes_part_id = clothes_ints[i * 2 + 1]; //当前选择的服装id
            GObject _gObject_list = _mainView.GetChild("L_Clothes_" + clothes_part_index.ToString());
            if (_gObject_list != null)
            {
                GList _gList = _gObject_list.asList;
                GComponent _item_Box = _gList.AddItemFromPool(UIPackage.GetItemURL("Custom", "Item_Box")).asCom;
                GList _item_list = _item_Box.GetChild("item_list").asList;
                _item_list.RemoveChildrenToPool();

                //加载全部服装缩略图
                if (clothes_part_index == 0)
                {
                    Clothes_Top_Kind[] _clothes_top_kinds = SekiaHelp.Sekia_EnumToArray<Clothes_Top_Kind>();
                    for (int n = 0; n < _clothes_top_kinds.Length; n++)
                    {
                        GButton item = _item_list.AddItemFromPool().asButton; //向列表添加新子级
                        Clothes_Top_Kind _clothes_top_kind = _clothes_top_kinds[n]; //lambda参数需要为固定值
                        string item_name = _clothes_top_kind.ToString(); //enum名作为物品名
                        item.title = item_name;
                        item.icon = UIPackage.GetItemURL("Custom", "p_o_top_" + item_name);
                        item.onClick.Add(() =>
                        {
                            _item_Box.GetChild("item_name").asTextField.text = item_name;
                            _item_Box.GetChild("item_icon").asLoader.icon = item.icon;
                            model.Change_Clothes_Top(_clothes_top_kind);
                        });

                        if (n == clothes_part_id)
                        {
                            item.onClick.Call(); //执行初始服装设置
                        }
                    }
                }
                else if (clothes_part_index == 1)
                {
                    Clothes_Bot_Kind[] _clothes_bot_kinds = SekiaHelp.Sekia_EnumToArray<Clothes_Bot_Kind>();
                    for (int n = 0; n < _clothes_bot_kinds.Length; n++)
                    {
                        GButton item = _item_list.AddItemFromPool().asButton; //向列表添加新子级
                        Clothes_Bot_Kind _clothes_bot_kind = _clothes_bot_kinds[n]; //lambda参数需要为固定值
                        string item_name = _clothes_bot_kind.ToString(); //enum名作为物品名
                        item.title = item_name;
                        item.icon = UIPackage.GetItemURL("Custom", "p_o_bot_" + item_name);
                        item.onClick.Add(() =>
                        {
                            _item_Box.GetChild("item_name").asTextField.text = item_name;
                            _item_Box.GetChild("item_icon").asLoader.icon = item.icon;
                            model.Change_Clothes_Bot(_clothes_bot_kind);
                        });

                        if (n == clothes_part_id)
                        {
                            item.onClick.Call(); //执行初始服装设置
                        }
                    }
                }
                else if (clothes_part_index == 2)
                {
                    Clothes_Shoes_Kind[] _clothes_shoes_kinds = SekiaHelp.Sekia_EnumToArray<Clothes_Shoes_Kind>();
                    for (int n = 0; n < _clothes_shoes_kinds.Length; n++)
                    {
                        GButton item = _item_list.AddItemFromPool().asButton; //向列表添加新子级
                        Clothes_Shoes_Kind _clothes_shoes_kind = _clothes_shoes_kinds[n]; //lambda参数需要为固定值
                        string item_name = _clothes_shoes_kind.ToString(); //enum名作为物品名
                        item.title = item_name;
                        item.icon = UIPackage.GetItemURL("Custom", "p_o_shoes_" + item_name);
                        item.onClick.Add(() =>
                        {
                            _item_Box.GetChild("item_name").asTextField.text = item_name;
                            _item_Box.GetChild("item_icon").asLoader.icon = item.icon;
                            model.Change_Clothes_Shoes(_clothes_shoes_kind);
                        });

                        if (n == clothes_part_id)
                        {
                            item.onClick.Call(); //执行初始服装设置
                        }
                    }
                }
            }

        }
    }

    void OnKeyDown(EventContext context)
    {
        if (context.inputEvent.keyCode == KeyCode.Space)
        {
#if UNITY_EDITOR
            UnityEditor.EditorApplication.isPlaying = false;
#else
            Application.Quit();
#endif
        }
    }
}
