https://blog.csdn.net/kylinok/article/details/116234399
ET Book 2.2：更好的协程

# ETTask
ETTask是对.Net原生async/await的简化包装 而async/await是一个异步方法语法糖
通过async/await写代码使得上下文连贯 具体的执行细节可以通过反编译细说但是没必要
    Task是多线程的 比如等待2秒钟这个异步任务相当于在新线程上执行Thread.Sleep
    ETTask是单线程的 相当于创建一个等待中的状态机 定时器执行时标记状态机为完成
定义异步方法时 代码分为：await前/await中/await后
    await前的代码是同步执行的
    await时创建状态机 当状态机被标记为完成时才执行await后的代码
使用上的区分：
    ETVoid：在主线程开启协程
    ETTask：在主线程开启协程or协程中开启 无返回值
    ETTask<>：在协程中开启另一个协程且有返回值

