ET中为了加强代码规范的约束引入了分析器进行语法检测

# ComponentOf/ChildOf
ComponentOf：
    当执行entity.GetComponent<-->时进行约束检测
    可以被添加的子级必须添加ComponentOf标签
        指定父级entity的类型时使用：[ComponentOf(typeof(parentType)]
        不指定父级entity类型时使用：[ComponentOf]

# StaticField
标记StaticField后 Unity重新编译时去清理这些全局字段