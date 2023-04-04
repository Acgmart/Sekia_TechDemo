---
title: ET 取消任务CancellationToken
categories:
- [Unity, ET]
date: 2020-06-20 11:30:19
---

\[toc\]本篇解释任务取消机制。 ET中提供了一种，在主线程取消ETTask的操作。 比如，描述一个异步移动任务：

```csharp
public ETTask MoveToAsync(..., CancellationToken cancellationToken)
{
    //任务相关设置

    this.moveTcs = new ETTaskCompletionSource();
    cancellationToken.Register(() => { this.moveTcs = null; });
    return this.moveTcs.Task;
}
```

这样的ETTask的特点是： 1.方法声明没有async标签，方法内部也就不能使用await标签； 2.在方法被引用时，必须await本方法，也就说只能在异步方法内调用： await MoveToAsync(..., cancellationToken); 如果不加await，编译器提示：此调用不会等待，将在调用完成之前继续当前方法； 3.从形式上来说，就是返回了一个未完成的任务，而且需要等待任务完成。 任务的完成需要ETTask被外部因素标记为已完成，这个支线程只能苦等。 类似的操作： 我们可以在ET中搜索相似的方法，关键词：**public ETTask** 搜索到的结果，比如：

```csharp
public ETTask<AssetBundle> LoadAsync(string path)
{
    this.tcs = new ETTaskCompletionSource<AssetBundle>();
    this.request = AssetBundle.LoadFromFileAsync(path);
    return this.tcs.Task;
}
```

这里声明了一个异步加载AssetBundle的任务，但是这个任务无法自己完成； 必须由方法外的Update方法标记任务为已完成，才返回AssetBundle实例。 所以，当在任务内注册CancellationToken后，我们具备了影响任务结果的能力。 CancellationToken注册的事件，可以直接关联到任务的暂停状态：

```csharp
public void Update()
{
    if(this.moveTcs == null)
        return; //暂停任务逻辑

    if(判定任务是否已完成)
    {
        var tcs = this.moveTcs;
        this.moveTcs = null; //暂停任务逻辑
        tcs.SetResult(); //标记任务已完成
        return;
    }

    //执行一轮任务逻辑
}
```

这样一来，外部可以随时暂停任务逻辑，并销毁ETTask： this.CancellationTokenSource?.Cancel(); 执行内容：this.moveTcs = null; 将ETTaskCompletionSource赋值为null，导致ETTask失去引用。 ETTask为值类型，丢失引用后，再次查询结果得到已完成，但是丢失后续任务。

# 未完成任务的活用

任务未完成期间，我们可以做很多事，比如切换场景、更新进度条、等待一段时间。 任务内和任务外同时运行着逻辑，分别思考着自己的事。 任务外逻辑可能会想：我刚才交代的事怎么还没完成？/我现在改主意了，我要重新安排！ 如果考虑把任务设计为可追溯型的，我们取消任务时甚至可以恢复到任务开始时的状态。 比如：安排依次建设游乐场、市政厅、沙滩公园，改主意为建设游乐场、菜市场、沙滩公园； 那么市政厅就应该被取消，不过逻辑复杂到这个程度的话，就是AI的范畴了。