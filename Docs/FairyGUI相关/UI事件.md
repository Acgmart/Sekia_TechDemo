# FairyGUI事件流程
首先我们需要一个委托来包装事件
EventListener _onClick;
他表示UI组件被点击后要执行的任务 为了方便处理逻辑需要一定的上下文

_onClick需要其他代码主动调用才实例化 EventListener
public EventListener onClick
{
    get { return _onClick ?? (_onClick = new EventListener(this, "onClick")); }
}

owner是DisplayObject 与gameObject一一对应
实例化EventListener需要owner和事件类型作为参数

简单的运行流程：
当用户通过交互点击UI 通过碰撞检测得到GameObject 再调用对应owner绑定的onClick事件

监听多种事件：
在owner身上绑定一个词典 key为事件类型 value为委托
按需实例化委托：
internal EventBridge GetEventBridge(string strType)
{
    if (_dic == null)
         _dic = new Dictionary<string, EventBridge>();

    EventBridge bridge = null;
    if (!_dic.TryGetValue(strType, out bridge))
    {
        bridge = new EventBridge(this);
        _dic[strType] = bridge;
    }
    return bridge;
}

委托类型：
有上下文和无上下文两种普通委托 以及Capture委托
Capture委托用于向父级传递冒泡事件 处理多UI组件链上的联动

冒泡事件：
参考文章：https://www.mianshigee.com/tutorial/fairygui/fb3033d7f70081e0.md/
一些特殊的事件，比如鼠标/触摸拖动事件，具备向父组件传递的特性，这个传递过程叫做冒泡。
例如当手指接触A元件时，A元件触发TouchBegin事件，
    然后A元件的父组件B触发TouchBegin事件，
    然后B的父组件C也触发TouchBegin事件，以此类推，直到舞台根部。
这个设计保证了所有相关的显示对象都有机会处理触摸事件，而不只是最顶端的显示对象。

冒泡过程可以被打断，通过调用EventContext.StopPropagation()可以使冒泡停止向父组件推进。

从上面的冒泡过程可以看出，事件处理的顺序应该是：
    A’s listeners->B’s listeners->C’s listeners，
    这里还有一种机制可以让链路上任意一个对象可以提前处理事件，这就是事件捕获。
    事件捕获是反向的，例如在上面的例子中，就是C先捕获事件，然后是B，再到A。
    所以所有事件处理的完整顺序应该是：
    C’s capture listeners->B’s capture listeners->A’s capture listeners->
    A’s listeners->B’s listeners->C’s listeners

捕获传递链是不能中止的，冒泡传递链可以通过StopPropagation中止。事件捕获的设计可以使父元件优于子元件和孙子元件检查事件。

并非所有事件都有冒泡设计，在非冒泡事件中，capture的回调优于普通回调，仅此而已，可以作为一个优先级特性来使用。

上下文 
EventContext：

sender 获得事件的分发者。

initiator 获得事件的发起者。一般来说，事件的分发者和发起者是相同的，但如果事件已发生冒泡，则可能不相同。参考下面冒泡的描述。

type 事件类型。

inputEvent 如果事件是键盘/触摸/鼠标事件，通过访问inputEvent对象可以获得这类事件的相关数据。

data 事件的数据。根据事件不同，可以有不同的含义。

StopPropagation 点击子节点的区域，父节点也能收到触摸事件，这就是事件冒泡的特性。如果你不想再向父节点传递，可以调用这个方法。

CaptureTouch 当鼠标左键释放或者手指抬起时，如果鼠标或者触摸位置已经不在组件范围内了，那么组件的TouchEnd事件是不会触发的。如果确实需要，可以请求捕获。在TouchBegin事件处理函数内，你可以调用context.CaptureTouch()，这样，无论鼠标在哪里释放（即使不在对象区域内），对象的onTouchEnd都会被调用。注意仅生效一次。在1.9.1SDK后，如果调用了CaptureTouch，那么GObject.onTouchMove事件将在手指（或鼠标左键）抬起前一直触发（无论手指或指针位置是不是在该对象上方），直到鼠标左键释放或者手指抬起。

UncaptureTouch 取消CaptureTouch发起的触摸事件捕获。

InputEvent：
对键盘事件和鼠标/触摸事件，可以通过EventContext.inputEvent获得此类事件的相关数据。

x y 鼠标或手指的位置；这是舞台坐标，因为UI可能因为自适配发生了缩放，所以如果要转成UI元件中的坐标，要使用GObject.GlobalToLocal转换。

keyCode 按键代码；

modifiers 参考UnityEngine.EventModifiers。

mouseWheelDelta 鼠标滚轮滚动值。

touchId 当前事件相关的手指ID；在PC平台，该值为0，没有意义。

isDoubleClick 是否双击。