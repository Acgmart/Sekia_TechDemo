https://developer.apple.com/videos/play/wwdc2016/606/

下文为该课程的翻译和个人理解：
-------------------------------------------------

Advanced Metal Shader Optimization
The Metal shading language is an easy-to-use programming language for writing graphics and compute functions which execute on the GPU. Dive deeper into understanding the design patterns, memory access models, and detailed shader coding best practices which reduce bottlenecks and hide latency. Intended for experienced shader authors with a solid understanding of GPU architecture and hoping to extract every possible cycle.
高级Metal着色器优化
Metal着色语言是一种易于使用的编程语言，用于编写在 GPU 上执行的图形和计算功能。 
本篇将深入了解设计模式、内存访问模型和减少瓶颈和隐藏延迟的着色器编码细节。 
适用于对GPU架构有深入了解并希望打通所有关节的老Shader程序员。

Our compiler is based on LVM.
我们的编译器基于LVM。

Here's a quick overview of the other Metal session, in case you missed them, and don't worry you can watch the recordings online. Yesterday we had part one and two of adopting Metal and earlier today we had part one and two of what's new in Metal, because there's quite a lot that's new in Metal.
And of course here's the last one, the one you're watching right now.
这是其他 Metal 课程的快速预览，以防你错过了它们，不要担心你可以在线观看录音。
昨天我们有adopting Metal 的第一和第二部分，今天早些时候我们有what's new in Metal的第一和第二部分，因为Metal中有很多新功能。
当然，这是最后一个，你现在正在看的这个(总共5篇)。

There's no point to doing low-level shader optimization until you've done the high-level optimizations before, like watching the other Metal talks from optimizing your draw calls, the structure of your engine and so forth.
在Shader的Low Level优化之前，需要确保渲染管线的High Level优化。
可观看其他Metal讨论如何优化您的绘制调用、引擎的结构等等。

//requiring that they qualify all buffers, arguments and pointers in the shading language with which address space they want to use.

# 前期准备
## 1.缓冲区参数的地址空间选择 Address space selection for buffer arguments
device address space
这是一个限制相对较少的地址空间。
可读写
无数据传输量限制
相对灵活的对齐限制

constant address space
仅可读
可传输数据量有限
更严格的对齐限制
针对大量大量访问进行优化

空间的选择：
如果数据的长度在变化，需要使用device address space。
固定长度的数据如果读取次数多可以放在constant，少则放在device。

例子：
模型的顶点坐标      - 长度可能发生变化   - 仅读取一次       - 使用device address space
透视矩阵            - 固定长度          - 大量读取          - 使用constant address space
蒙皮矩阵            - 固定骨骼数量      - 所有顶点共享      - 使用constant address space
per-instance数据   - 根据instance数变化 - instance内全部顶点共享  - 使用device address space

## 2.缓冲区预加载 buffer preloading
专用硬件优化特定Shader数据的加载与存储：
    context buffer
    vertex buffer
这依赖于：
    Shader中对数据的访问方式
    数据被存放的address space

因此，让我们从常量缓冲区预加载开始。所以这里的想法是，与其通过常量地址空间加载，我们实际上可以做的是将您的数据放入特殊的常量寄存器中，这样 ALU 访问速度更快。
因此，只要我们确切知道将读取哪些数据，我们就可以做到这一点。
如果您的偏移量是已知的编译时间，这很简单。但是，如果您的偏移量直到运行时才知道，那么我们需要一些关于您正在读取多少数据的额外信息。
因此，向编译器表明这一点通常需要两个步骤。首先，您需要确保此数据位于常量地址空间中。
此外，您需要指出您的访问是静态有界的。
So let's start with constant buffer preloading. 
So the idea here is that rather than loading through the constant address space, 
what we can actually do is take your data and put it into special constant registers that are even faster for the ALU to access.
So we can do this as long as we know exactly what data will be read.
If your offsets are known a compile time, this is straightforward. But if your offsets aren't known until run time then we need a little bit of extra information about how much data that you're reading.
So indicating this to the compiler is usually a matter of two steps. First, you need to make sure that this data is in the constant address space.
And additionally you need to indicate that your accesses are statically bounded.

The best way to do this is to pass your arguments by reference rather than pointer where possible. If you're passing only a single item or a single struct, this is straightforward, you can just change your pointers to references and change your accesses accordingly. This is a little different if you're passing an array that you know is bounded.
So what you do in this case is you can embed that size array and pass that struct by reference rather than passing the original pointer.
So we can put this into practice with an example at a forward lighting fragment shader. So as you can see in sort of the original version what we have are a bunch of arguments that are passed as regular device pointers. And this doesn't expose the information that we want.
So we can do better than this.
最好的方法是尽可能通过引用而不是指针传递参数。如果您只传递一个物品或一个结构，这很简单，您只需更改指向引用的指针并相应地更改您的访问。如果你传递一个你知道是有界的数组，这有点不同。
因此，在这种情况下，您可以嵌入该大小数组并通过引用传递该结构，而不是传递原始指针。
因此，我们可以通过前向照明片段着色器的示例将其付诸实践。因此，正如您在原始版本中看到的那样，我们拥有的是一堆作为常规设备指针传递的参数。这不会暴露我们想要的信息。
所以我们可以做得比这更好。

Instead if we note the number of lights is bonded what we can do is we can put the light data and the count together into a single struct like this.
And we can pass that struct in the constant address space as a reference like this.
And so that gets us constant buffer preloading.
Let's look at another example of how this can affect you in practice.
相反，如果我们注意到灯光的数量是绑定的，我们可以做的是我们可以将灯光数据和计数放在一个像这样的单个结构中。
我们可以像这样在常量地址空间中将该结构作为引用传递。
这样我们就可以进行恒定的缓冲区预加载。
让我们看另一个例子，说明这在实践中如何影响你。

So, there are many ways to implement a deferred render, but what we find is that the actually implementation choices that you make can have a big impact on the performance that you achieve in practice. One pattern that's common now is to use a single shader to accumulate the results of all lights.
And what you can see form the declaration of this function, is that it can potentially read any or all lights in the scene and that means that your input size is unbounded. Now, on the other hand if you're able to structure your rendering such that each light is handled in its own draw call then what happens is that each light only needs to read that light's data and it's shader and that means that you can pass it in the constant address space and take advantage of buffer preloading.
因此，有很多方法可以实现延迟渲染，但我们发现您所做的实际实现选择会对您在实践中实现的性能产生重大影响。现在常见的一种模式是使用单个着色器来累积所有灯光的结果。
从这个函数的声明中你可以看到，它可以潜在地读取场景中的任何或所有灯光，这意味着你的输入大小是无限的。现在，另一方面，如果您能够构建渲染结构，以便在自己的绘制调用中处理每个灯光，那么会发生什么情况是每个灯光只需要读取该灯光的数据和它的着色器，这意味着您可以通过它在恒定地址空间中并利用缓冲区预加载。

In practice we see that on A8 later GPUs that this is a significant performance win. Now let's talk about vertex buffer preloading. The idea of vertex buffer preloading is to reuse the same dedicated hardware that we would use for a fix function vertex fetching. And we can do this for regular buffer loads as long as the way that you access your buffer looks just like fix function vertex fetching. So what that means is that you need to be indexing using the vertex or instance ID. Now we can handle a couple additional modifications to the vertex or instance IDs such as applying a deviser and that's with or without any base vertex or instance offsets you might have applied at the API level.
在实践中，我们看到在 A8 之后的 GPU 上，这是一个显着的性能提升。现在让我们谈谈顶点缓冲区预加载。顶点缓冲区预加载的想法是重用我们将用于修复函数顶点获取的相同专用硬件。只要您访问缓冲区的方式看起来就像修复函数顶点获取一样，我们就可以对常规缓冲区加载执行此操作。所以这意味着您需要使用顶点或实例 ID 进行索引。现在，我们可以处理对顶点或实例 ID 的一些额外修改，例如应用设计者，以及您可能已在 API 级别应用的任何基本顶点或实例偏移量。

Of course the easiest way to take advantage of this is just to use the Metal vertex descriptor functionality wherever possible. But if you are writing your own indexing code, we strongly suggest that you layout your data so that vertexes fetch linearly to simplify buffer indexing. Note that this doesn't preclude you from doing fancier things, like if you were rendering quads and you want to pass one value to all vertices in the quad, you can still do things like indexing by vertex ID divided by four because this just looks like a divider.
当然，利用这一点最简单的方法就是尽可能使用 Metal 顶点描述符功能。但是，如果您正在编写自己的索引代码，我们强烈建议您对数据进行布局，以便线性获取顶点以简化缓冲区索引。请注意，这并不妨碍您做一些更花哨的事情，例如，如果您正在渲染四边形并且您想将一个值传递给四边形中的所有顶点，您仍然可以执行诸如按顶点 ID 除以四的索引之类的事情，因为这看起来像一个分隔符。

## 3.处理片段函数资源写入 fragment function resource writes
So now let's move on to a couple shader stage specific concerns.
In iOS 10 we introduced the ability to do resource writes from within your fragment functions. And this has interesting implications for hidden surface removal.
So prior to this you might have been accustomed to the behavior that a fragment wouldn't need to be shaded as long as an opaque fragment came in and occluded it.
So this is no longer true specifically if your fragment function is doing resource writes, because those resource writes still need to happen.
所以现在让我们继续讨论几个着色器阶段特定的问题。
在 iOS 10 中，我们引入了从片段函数中进行资源写入的能力。这对隐藏表面的去除具有有趣的意义。
所以在此之前，您可能已经习惯了这样的行为，即只要不透明的片段进入并遮挡它，片段就不需要着色。
因此，如果您的片段函数正在执行资源写入，这将不再适用，因为这些资源写入仍然需要发生。


So instead your behavior really only depends on what's come before. And specifically what happens depends on whether or not you've enabled early fragment tests on your fragment function. If you have enabled early fragment tests, once it's rasterized as long as it also passes the early depth and stencil tests. If you haven't specified early fragment tests, then your fragment will be shaded as long as it's rasterized.
So from a perspective of minimizing your shading, what you want to do is use early fragment tests wherever possible. But there are a couple additional things that you can do to improve the rejection that you get.
And most of these boil down to draw order. You want to draw these objects, the objects where the fragment functions do resource writes after opaque objects. And if you're using these objects to update your depth and stencil buffers, we strongly suggest that you sort these buffer from front to back.
因此，您的行为实际上只取决于之前发生的事情。具体会发生什么取决于您是否在片段函数上启用了早期片段测试。如果您启用了早期片段测试，只要它也通过早期深度和模板测试，一旦它被光栅化。如果您没有指定早期片段测试，那么只要您的片段被光栅化，它就会被着色。
因此，从最小化阴影的角度来看，您想要做的是尽可能使用早期片段测试。但是你可以做一些额外的事情来改善你得到的拒绝。
其中大部分归结为绘制顺序。您想要绘制这些对象，片段函数在不透明对象之后执行资源写入的对象。如果您使用这些对象来更新深度和模板缓冲区，我们强烈建议您从前到后对这些缓冲区进行排序。

## 4.如何优化computer内核 how to optimize computer kernels
Note that this guidance should sound fairly familiar if you've been dealing with fragment functions that do discard or modify your depth per pixel. Now let's talk about compute kernels. Since the defining characters of a compute kernels that you can structure your computation however you want.
请注意，如果您一直在处理会丢弃或修改每像素深度的片段函数，那么本指南听起来应该相当熟悉。现在让我们谈谈计算内核。由于计算内核的定义特征，您可以根据需要构建计算。

Let's talk about what factors influence how you do this on iOS.
First we have computer thread launch overhead.
So on A8 and later GPUs there's a certain amount of time that it takes to launch a group of compute threads. So if you don't do enough work from within a single compute thread you can potentially, it leaves the hardware underutilized and leave performance on the table.
And a good way to deal with this and actually a good pattern for writing computer kernels on iOS in general is to actually process multiple conceptual work items in a single compute threat. And in particular a pattern that we find works well is to reuse values not by passing them through thread group memory, but rather by reusing values loaded for one work item when you're processing the next work item in the same compute thread. And it's best to illustrate this with an example.
So this is a syllable filter kernel, this is sort of the most straightforward version of it, as you see, it reads as a three- region of its source and produces one output pixel.
So if instead we apply the pattern of processing multiple work items in a single compute thread, we get something that looks like this.
让我们谈谈哪些因素会影响您在 iOS 上的执行方式。
首先，我们有计算机线程启动开销。
因此，在 A8 和更高版本的 GPU 上，启动一组计算线程需要一定的时间。因此，如果您没有在单个计算线程中做足够的工作，您可能会导致硬件未得到充分利用，并将性能留在桌面上。
处理这个问题的一个好方法，实际上是在 iOS 上编写计算机内核的一个很好的模式，就是在单个计算威胁中实际处理多个概念性工作项。特别是，我们发现一种很好的模式是重用值，而不是通过将它们传递给线程组内存，而是通过重用在同一计算线程中处理下一个工作项时为一个工作项加载的值。最好用一个例子来说明这一点。
所以这是一个音节过滤器内核，这是它最直接的版本，如您所见，它读取为其源的三个区域并产生一个输出像素。
因此，如果我们改为在单个计算线程中应用处理多个工作项的模式，我们会得到如下所示的结果。

Notice now that we're striding by two pixels at a time. So processing the first pixel looks much as it did before. We read the 3 by 3 region. We apply the filter and we write up the value. But now let's look at how pixel 2 is handled. So stents are striding by two pixels at a time we need to make sure that there is a second pixel to process.
And now we read its data.
Note here that a 2 by 3 region of what this pixel wants was already loaded by the previous pixel. So we don't need to load it again, we can reuse those old values. All we need to load now is the 1 by 3 region that's new to this pixel.
After which, we can apply the filter and we're done.
Note that as a result we're not doing 12 texture reads, instead of the old 9, but we're producing 2 pixels. So this is a significant reduction in the amount of texture reads per pixel.
Of course this pattern doesn't work for all compute use cases. Sometimes you do still need to pass data through thread group memory.
And in that case, when you're synchronizing between threads in a thread group, an important thing to keep in mind is that you want to use the barrier with the smallest possible scope for the threads that you need to synchronize.
现在请注意，我们一次跨过两个像素。所以处理第一个像素看起来和以前一样。我们读取 3 by 3 区域。我们应用过滤器并写下值。但现在让我们看看如何处理像素 2。所以支架一次跨过两个像素，我们需要确保有第二个像素要处理。
现在我们读取它的数据。
请注意，该像素所需的 2 x 3 区域已由前一个像素加载。所以我们不需要再次加载它，我们可以重用那些旧值。我们现在需要加载的只是这个像素新的 1 x 3 区域。
之后，我们可以应用过滤器，我们就完成了。
请注意，因此我们没有进行 12 次纹理读取，而不是旧的 9 次，但我们正在生成 2 个像素。因此，这显着减少了每个像素的纹理读取量。
当然，这种模式不适用于所有计算用例。有时您仍然需要通过线程组内存传递数据。
在这种情况下，当您在线程组中的线程之间进行同步时，要记住的重要一点是，您希望对需要同步的线程使用具有最小可能范围的屏障。
特别是，如果您的线程组适合单个 SIMD，则不需要 Metal 中的常规线程组屏障功能。您可以使用 iOS 10 中引入的新 SIMD 组屏障功能。

In particular, if your thread group fits within a single SIMD, the regular thread group barrier function in Metal is unnecessary. What you can use instead is the new SIMD group barrier function introduced in iOS 10.
And what we find is actually the targeting your thread group to fit within a single SIMD and using SIMD group barrier is often faster than trying to use a larger thread group in order to squeeze that additional reuse, but having to use thread group barrier as a result. So that wraps things up for me, in conclusion, make sure you're using the appropriate address space for each of your buffer arguments according to the guidelines that we described.
Structure your data and rendering to take maximal advantage of constant and vertex buffer preloading.
Make sure you're using early fragment tests to reject as many fragments as possible when you're doing resource writes. Put enough work in each compute thread so you're not being limited by your compute thread launch overhead. And use the smallest barrier for the job when you need to synchronize between threads in a thread group. And with that I'd like to pass it back to Fiona to dive deeper into tuning shader code.
Thank you, Alex.
特别是，如果您的线程组适合单个 SIMD，则不需要 Metal 中的常规线程组屏障功能。您可以使用 iOS 10 中引入的新 SIMD 组屏障功能。
我们发现实际上是针对您的线程组以适应单个 SIMD 并使用 SIMD 组屏障通常比尝试使用更大的线程组以挤压额外的重用更快，但必须使用线程组屏障作为结果。因此，总而言之，请确保您根据我们描述的指南为每个缓冲区参数使用适当的地址空间。
结构化数据和渲染以最大限度地利用常量和顶点缓冲区预加载。
确保在进行资源写入时使用早期片段测试来拒绝尽可能多的片段。在每个计算线程中投入足够的工作量，这样您就不会受到计算线程启动开销的限制。当您需要在线程组中的线程之间进行同步时，请为作业使用最小的障碍。有了这个，我想把它传回给 Fiona，以便更深入地研究调整着色器代码。
谢谢你，亚历克斯。

# Shader Performance Fundamentals 着色器性能基础知识
因此，在进入细节之前，我想回顾一下 GPU 的一些一般特性以及您可能遇到的瓶颈。你们所有人可能都熟悉这一点，但我认为我应该快速回顾一下。
因此，对于 GPU，您通常拥有一组资源。着色器受到这些资源之一的瓶颈是相当普遍的。因此，例如，如果您受到内存带宽的限制，改进着色器中的其他内容通常不会带来任何明显的性能提升。
虽然识别这些瓶颈并专注于它们以提高性能很重要，但实际上改进不是瓶颈的东西仍然有好处。例如，在该示例中，如果您在内存使用方面遇到瓶颈，但随后您改进了算法以提高效率，即使您没有提高帧速率，您仍然可以节省电量。当然，在移动设备上，省电总是很重要的。所以这不是什么可以忽略的，只是因为在这种情况下你的帧速率不会上升。因此，这里的着色器有四个典型的瓶颈需要牢记。
So, before jumping into the specifics here, I want to go over some general characteristics of GPUs and the bottlenecks you can encounter. And all of you may be familiar with this, but I figure I should just do a quick review.
So with GPUs typically you have a set of resources. And it's fairly common for a shader to be bottlenecked by one of those resources. And so for example if you're bottlenecked by memory bandwidth, improving other things in your shader will often not give any apparent performance improvement.
And while it is important to identify these bottlenecks and focus on them to improve performance, there is actually still benefit to improving things that aren't bottlenecks. For example, in that example if you are bottlenecked at memory usage, but then you improve your arithmetic to be more efficient, you will still save power even if you are not improving your frame rate. And of course being on mobile, saving power is always important. So it's not something to ignore, just because your frame rate doesn't go up in that case. So there's four typical bottlenecks to keep in mind in shaders here. 

1.ALU 带宽 ALU bandwidth. 
GPU 可以做的数学运算量
The amount of math that the GPU can do.
2.memory bandwidth 内存带宽
GPU 可以从系统内存加载的数据量
the amount of data that the GPU can load from system memory. 
The other two are little more subtle. 
3.memory issue rate 内存事件率
它表示可以执行的内存操作数
这可能会出现在您的内存操作较小的情况下，或者您正在使用大量线程组内存等等。
represents the number of memory operations that can be performed. 
And this can come up in the case where you have smaller memory operations, 
or you're using a lot of thread group memory and so forth.
4.latency / occupancy / register usage 延迟 占用 寄存器的使用
the last one, which I'll go into detail a bit more about later
最后一个，我稍后将详细介绍的是。你可能听说过，但我会一直保存到最后。

## 数据类型
因此，为了尝试缓解其中的一些瓶颈，并提高整体着色器性能和效率，我们将在这里查看四类优化机会。
第一个是数据类型。优化着色器时首先要考虑的是选择数据类型。在选择数据类型时要记住的最重要的事情是 A8 和更高版本的 GPU 具有 16 位寄存器单元，这意味着例如，如果您使用 32 位数据类型，则寄存器空间是两倍，两倍的带宽，可能是两倍的功率等等，它只是两倍的东西。
So to try to alleviate some of these bottlenecks, and improve overall shader performance and efficiency, we're going to look at four categories of optimization opportunity here.
And the first one is data types. And the first thing to consider when optimizing your shader is choosing your data types. And the most important thing to remember when you're choosing data types is that A8 and later GPUs have 16-bit register units, which means that for example if you're using a 32-bit data type, that's twice the register space, twice the bandwidth, potentially twice the power and so-forth, it's just twice as much stuff.

因此，相应地您将节省寄存器，您将获得更快的性能，您将通过使用更小的数据类型获得更低的功耗。尽可能使用 half 和 short 来表示算术。
能源方面，half比float便宜。而且float比int便宜，但即使在整数中，较小的整数也比较大的整数便宜。
So, accordingly you will save registers, you will get faster performance, you'll get lower power by using smaller data types. Use half and short for arithmetic wherever you can.
Energy wise, half is cheaper than float. And float is cheaper than integer, but even among integers, smaller integers are cheaper than bigger ones.


节约寄存器最有效的方法是使用 half 进行纹理读取和插值，因为大多数时候你真的不需要 float 来处理这些。请注意，我不是指您的纹理格式。我的意思是您用来存储纹理样本或插值结果的数据类型。
And the most effective thing you can do to save registers is to use half for texture reads and interpolates because most of the time you really do not need float for these. And note I do not mean your texture formats. I mean the data types you're using to store the results of a texture sample or an interpolate.

A8 在后来的 GPU 中相当方便并且比其他一些 GPU 更容易使用更小的数据类型的一个方面是数据类型转换通常是免费的，即使在 float 和 half 之间，这意味着您不必担心，哦，我在这里尝试使用 half 是不是引入了太多的转换？这会花费太多吗？值得还是不值得？不，它可能很快，因为转换是免费的，所以你可以在任何你想要的地方使用half，而不用担心类型转换的性能损失。这里要记住的一件事是半精度数字和限制与浮点数不同。
And one aspect of A8 in later GPUs that is fairly convenient and makes using smaller data types easier than on some other GPUs is that data type conversions are typically free, even between float and half, which means that you don't have to worry, oh am I introducing too many conversions in this by trying to use half here? Is this going to cost too much? Is it worth it or not? No it's probably fast because the conversions are free, so you can use half wherever you want and not worry about that part of it. The one thing to keep in mind here though is that half-precision numerics and limitations are different from float.


例如，这里可能出现的一个常见错误是人们会将 65,535 写为一半，但这实际上是无穷大。因为这比最大一半大。因此，通过了解这些限制是什么，您将能够更好地知道您应该在哪里使用和不应该使用一半。并且不太可能在着色器中遇到意外错误。

因此，使用较小整数数据类型的一个示例应用程序是线程 ID。

正如那些从事计算机内核工作的人所知道的那样，线程 ID 被用于您的程序中。

因此使它们更小可以显着提高算术性能，并且可以节省寄存器等。

所以本地线程 ID，没有理由像这种情况下那样为它们使用 uint，因为本地线程 ID 不能有那么多线程 ID。

对于全局线程 ID，通常您可以使用 ushort，因为大多数时候您没有那么多全局线程 ID。当然，这取决于您的程序。但在大多数情况下，你不会超过 2 到 16 减 1，所以据说你可以做到这一点。

这将是更低的功率，它会更快，因为所有涉及线程 ID 的算术现在都会更快。所以我强烈推荐这个。此外，请记住，在类 C 语言（当然包括 Metal）中，操作的精度由较大的输入类型定义。

例如，如果您将浮点数乘以一半，那是浮点运算而不是一半运算，它会被提升。
And a common bug that can come up here for example is people will write 65,535 as a half, but that is actually infinity. Because that's bigger than the maximum half. And so by being aware of what these limitations are, you'll better be able to know where you perhaps should and shouldn't use half. And less likely to encounter unexpected bugs in your shaders.

So one example application for using smaller integer data types is thread IDs.

And as those of you who worked on computer kernels will know, thread IDs are used all over your programs.

And so making them smaller can significantly increase the performance of arithmetic, and can save registers and so forth.

And so local thread IDs, there's no reason to ever use uint for them as in this case, because local thread IDs can't have that many thread IDs.

For global thread IDs, usually you can get away with a ushort because most of the time you don't have that many global tread IDs. Of course it depends on your program. But in most cases, you won't go over 2 to the 16 minus 1, so it is said you can do this.

And this is going to be lower power, it's going to be faster because all of the arithmetic involving your thread ID is now going to be faster. So I highly recommend this wherever possible. Additionally, keep in mind that in C like languages, which of course includes Metal, the precision of an operation is defined by the larger of the input types.

For example, if you're multiplying a float by a half, that's a float operation not a half operation, it's promoted.

So accordingly, make sure not to use float literals when not necessary, because that will turn here what appears to be a half operation, it takes a half and returns a half, into a float operation. Because by the language semantics, that's actually a float operation since at least one of the inputs is float.

And so you probably want to do this.

This will actually be a half operation. This will actually be faster.

This is probably what you mean. So be careful not to inadvertently introduce float precision arithmetic into your code when that's not what you meant. And while I did mention that smaller data types are better, there's one exception to this rule and that is char.

Remember as I said that native data type size on A8 and later GPUs is 16-bit, not 8-bit.

And so char is not going to save you any space or power or anything like that and furthermore there's no native 8-bit arithmetic. So it sort of has to be emulated. It's not overly expensive if you need it, feel free to use it. But it may result in extra instructions. So don't unnecessarily shrink things to char that don't actually need it. So next we have arithmetic optimizations, and pretty much everything in this category affects ALU bandwidth. The first thing you can do is always use Metal built-ins whenever possible. They're optimized implementations for a variety of functions. They're already optimized for the hardware. It's generally better than implementing them yourself.

And in particular, there are some of these that are usually free in practice.

And this is because GPUs typically have modifiers. Operations that can be performed for free on the input and output of instructions. And for A8 and later GPUs these typically include negate, absolute value, and saturate as you can see here, these three operations in green. So, there's no point to trying to "be clever" and speed up your code by avoiding those, because again, they're almost always free. And because they're free, you can't do better than fee. There's no way to optimize better than free.

A8 and later GPUs, like a lot of others nowadays, are scalar machines.

And while shaders are typically written with vectors, the compiler is going to split them all apart internally. Of course, there's no downside to writing vector code, I mean often it's clearer, often it's more maintainable, often it fits what you're trying to do, but it's also no better than writing scaler code from a compiler perspective and the code you're going to get.

So there's no point in trying to vectorize code that doesn't really fit a vector format, because it's just going to end up the same thing in the end, and you're kind of wasting your time. However, as a side note, which I'll go into more detail a lot later, in later A8 and later GPUs, do have vector load in store even though they do not have vector arithmetic. So this only applies to arithmetic here.

Instruction Level Parallelism is something that some of you may have used optimizing for, especially if you've done work on CPUs. But on A8 and later GPUs this is generally not a good thing to try to optimize for because it typically works against registry usage, and registry usage typically matters more.

So a common pattern you may have seen is a kind of loop where you have multiple accumulators in order to better deal with latency on a CPU.

But on A8 and later GPUs this is probably counterproductive. You'd be better off just using one accumulator. Of course this applies to much more complex examples than the artificial simple ones here.

Just write what you mean, don't try to restructure your code to get more ILP out of it. It's probably not going to help you at best, and at worst, you just might get worse code.

So one fairly nice feature of A8 and later GPUs is that they have very fast select instructions that is the ternary operator.

And historically it's been fairly common to use clever tricks, like this to try to perform select operations in ternaries to avoid those branches or whatever. But on modern GPUs this is usually counterproductive, and especially on A8 later GPUs because the compiler can't see through this cleverness. It's not going to figure out what you actually mean. And really, this is really ugly.

You could just have written this. And this is going to be faster, shorter, and it's actually going to show what you mean.

Like before, being overly clever will often obfuscate what you're trying to do and confuse the compiler.

Now, this is a potential major pitfall, hopefully this won't come up too much.

On modern GPUs most of them do not have integer division or modulus instructions, integer not float.

So avoid divisional modulus by denominators that are not literal or function consonants, the new feature mentioned in some of the earlier talks.

So in this example, what we have over here, this first one where the denominator is a variable, that will be very, very slow. Think hundreds of clock seconds.

But these other two examples, those will be very fast. Those are fine. So don't feel like you have to avoid that.

# fast-math
So, finally the topic of fast-math.

So in Metal, fast-math is on by default. And this is because compiler fast-math optimizations are critical to performance Metal shaders. They can give off in 50% performance gain or more over having fast-math off. So it's no wonder it's on be default.

And so what exactly do we do in fast-math mode? Well, the first is that some of the Metal built-in functions have different precision guarantees between fast-math and non fast-math. And so in some of them they will have slightly lower precision in fast-math mode to get better performance.

The compiler may increase the intermediate precision of your operations like by forming a fuse multiple add instructions.

It will not decrease the intermediate precision. So for example if you write a float operation you will get an operation that is at least a float operation. Not a math operation. So if you want to write half operations you better write that, the compiler will not do that for you, because it's not allowed to. It can't your precision like that. We do ignore strict if not a number, infinity steal, and sign zero semantics, which is fairly important, because without that you can't actually prove that x times zero is equal to zero.

But we will not introduce a new not at new NaNs, not a number because in practice that's a really nice way to annoy developers, and break their code and we don't want to do that. And the compiler will perform arithmetic re-association, but it will not do arithmetic distribution. And really this just comes down to what doesn't break code and makes it faster versus what does break code. And we don't want to break code.

So if you absolutely cannot use fast-math for whatever reason, there are some ways to recover some of that performance.

Metal has a fused multiply-add built in which you can see here. Which allows you to directly request a fused multiply-add instructions. And of course if fast-math is off, the compiler is not even allowed to make those, it cannot change one bit of your rounding, it is prohibited. So if you want to use fused multiply-add and fast-math is off, you're going to have to use the built-in. And that will regain some of the performance, not all of it, but at least some. So, on our third topic, control flow.
所以，最后是快速数学的话题。

所以在 Metal 中，快速数学是默认开启的。这是因为编译器快速数学优化对金属着色器的性能至关重要。与快速数学相比，它们可以带来 50% 或更多的性能提升。所以难怪它是默认的。

那么我们在快速数学模式下到底要做什么呢？嗯，首先是一些 Metal 内置函数在快速数学和非快速数学之间有不同的精度保证。因此，在其中一些中，它们在快速数学模式下的精度会略低一些，以获得更好的性能。

编译器可能会增加操作的中间精度，例如通过形成熔断多条添加指令。

它不会降低中间精度。因此，例如，如果您编写一个浮动操作，您将得到一个至少是一个浮动操作的操作。不是数学运算。所以如果你想写一半的操作你最好写那个，编译器不会为你这样做，因为它是不允许的。它不能像你那样精确。我们确实忽略了严格（如果不是数字）、无穷大窃取和符号零语义，这是相当重要的，因为没有这些，您实际上无法证明 x 乘以零等于零。

但是我们不会在新的 NaN 上引入新的 not，而不是数字，因为在实践中这是一种非常好的方式来惹恼开发人员，并破坏他们的代码，我们不想这样做。并且编译器将执行算术重新关联，但不会执行算术分配。实际上，这只是归结为不会破坏代码并使其更快而不是破坏代码的东西。而且我们不想破坏代码。

因此，如果您出于某种原因绝对不能使用快速数学，有一些方法可以恢复其中的一些性能。

Metal 有一个内置的融合乘法加法，你可以在这里看到。这允许您直接请求融合乘加指令。当然，如果快速数学关闭，编译器甚至不允许制作这些，它不能改变你的四舍五入，这是被禁止的。因此，如果您想使用融合乘加并且关闭快速数学，您将不得不使用内置的。这将恢复一些性能，不是全部，但至少是一些。所以，关于我们的第三个主题，控制流。


Predicated GP control flow is not a new topic and some of you may already be familiar with it. But here's a quick review of what it means for you.

Control flow that is uniform across the SIMD, that is every thread is doing the same thing, is generally fast. And this is true even if the compiler can't see that. So if your program doesn't appear uniform, but just happens to be uniform when it runs, that's still just as fast. And similarly, the opposite of this divergence, different lanes doing different things, well in that case, it potentially may have to run all of the different paths simultaneously unlike a CPU which only takes one path at a time.

And as a result it does more work, which of course means that inefficient control flow can affect any of the bottlenecks, because it just outright means the GPU is doing more stuff, whatever that stuff happens to be.

So, the one suggestion I'll make on the topic of control flow is to avoid switch fall-throughs. And these are fairly common in CPU code. But on GPUs they can potentially be somewhat inefficient, because the compiler has to do fairly nasty transformations to make them fit within the control flow model of GPUs. And often this will involve duplicating code and all sort of nasty things you probably would rather not be happening.

So if you can find a nice way to avoid these switch fall-throughs in your code, you'll probably be better off.

So now we're on to our final topic. Memory access. And we'll start with the biggest pitfall that people most commonly run into and that is dynamically indexed non-constant stack arrays. Now that's quite a mouthful, but a lot of you probably are familiar with code that looks vaguely like this.

You have an array that consist of values that are defined in runtime and vary between each thread or each function call. And you index it to the array with another value that is also a variable. That is a dynamically indexed non-constant stack array.

Now before we go on, I'm not going to ask you to take for grabs at the idea that stacks are slow on GPUs. I'm going to explain why.

So, on CPUs typically you have like a couple threads, maybe a dozen threads, and you have megabytes of cache split between those threads. So every thread can have hundreds of kilobytes of stack space before they get really slow and have to head off to main memory.

On a GPU you often have tens of thousands of threads running. And they're all sharing a much smaller cache too. So when it comes down to it each thread has very, very little space for data for a stack.

It's just not meant for that, it's not efficient and so as a general rule, for most GPU programs, if you're using the stack, you've already lost. It's so slow that almost anything else would have been better.

And an example for a real world app is at the start of the program it needed to select one of two float for vectors, so it used a 32-byte array, an array of two float fours and tried to select between them using this stack array. And that caused a 30% performance loss in this program even though it's only done once at the start. It can be pretty significant.

And of course every time we improve the compiler we are going to try harder and harder to avoid, do anything we can to avoid generating these stack access because it is that bad.

Now I'll show you two examples here that are okay.

This other one, you can see those are constants, not variables. It's not a non-constant stack array and that's fine because the values don't vary per threads, they don't need to be duplicated per thread.

So that's okay. And this one is also okay. Wait, why? It's still a dynamically indexed non-constant stack array.

But it's only done dynamically indexed because of this loop.

And the compiler is going to unroll that loop. In fact, your compiler aggressively unrolls any loop that is accessing the stack to try to make it stop doing that.

So in this case after it's unrolled it will no longer be dynamically indexed, so it will be fast. And this is worth mentioning, because this is a fairly common pattern in a lot of graphics code and I don't want to scare you into not doing that when it's probably fine.

So now that we've gone over the topic of how to not do certain types of loads and stores, let's go on to making the loads and stores that we do actually fast.

Now while A8 and later GPUs use scalar arithmetic, as I went over earlier, they do have vector memory units.

And one big vector loading source of course faster than multiple smaller ones that sum up to the same size.

And this typically effects the memory issue rate bottleneck because if you're running through a loads, that's fewer loads.

And, so as of iOS 10, one of our new compiler optimizations, is we will try to vectorize some loads and stores that go to neighboring memory locations wherever we can, because again it can give good performance improvements.

But nevertheless, this is one of the cases where working with the compiler can be very helpful, and I'll give an example.

So as you can see here, here's a simple loop that does some arithmetic and reads in an array of structures, but on each iteration, it reads just two loads. Now we would want that to be one if we could, because one is better than two. And the compiler wants that too. It wants to try to vectorize this but it can't, because A and C aren't next to each other in memory so there's nothing it can do. The compiler's not allowed to rearrange your structs, so we've got two loads.

There's two solutions to this.

Number one, of course, just make it a float to, now it's a vector load, you're done.

One load, a set of two, we're all good.

Also, as of iOS 10, this should also be equally fast, because here, we've reordered our struct to put the values next to each other, so the compiler can now vectorize the loads when it's doing it. And this is an example again of working with the compiler, you've allowed the compiler to do something it couldn't before, because you understand what's going on. You understand how the patterns need to be to make the compiler happy and make it able to do a .

So, another thing to keep in mind with loads and stores is that A8 and later GPUs have dedicated hardware for device memory addressing, but this hardware has limits.

The offset for accessing device memory must fit within a signed integer. Smaller types like short and ushort are also okay, in fact they're highly encouraged, because those do also fit within a signed integer.

However, of course uint does not because it can have values out of range of signed integer.

And so if the compiler runs into a situation where the offset is a uint and it cannot prove that it will safely fit within a signed integer, it has to manually calculate the address, rather than letting the dedicated hardware do it. And that can waste power, it can waste ALU performance and so forth. It's not good. So, change your offset to int, now the problem's solved. And of course taking advantage to this will typically save you ALU bandwidth.

So now on to our final topic that I sort of glossed over earlier, latency and occupancy.

So one of the core design tenants of modern GPUs is they hide latency by using large scale multithreading. So when they're waiting for something slow to finish, like a texture read, they just go and run another thread instead of sitting there doing nothing while waiting. And this is fairly important because texture reads typically take a couple hundred cycles to complete on average.

And so the more latency you have in a shader, the more threads you need to hide that latency, and how many threads can you have? Well it's limited by the fact that you have a fixed set of resources that are shared between threads in a thread group. So clearly depending on how much each thread uses, you have a limitation on the number of threads. And the two things that are split are the number of registers and thread group memory. So if you use more registers per thread, now you can't have as many threads. Simple enough. And if you use more thread group memory per thread, again you run into the same problem, more thread your memory per thread means to your threads.

And you can actually check out the occupancy of your shader by using MTLComputePipeLineState incurring maxTotalThreadsPerThreadgroup, which will tell you what the actual occupancy of your shader is based on the register usage and the thread group memory usage. And so when we say a shader is latency limited, it means you have too few threads to hide the latency of a shader. And there's two things you can do there, you can either reduce the latency of your shader, your save registers or whatever else it is that is preventing you from having more threads.

So, since it's kind of hard to go over latency in a very large complex shader. I'll go over a little bit of a pseudocode example that will hopefully give you a big of an intuition of how to think about latency and how to sort of mentally model in your shaders.

So, here's an example of a REAL dependency. We have a texture sample, and then we use the operative of that texture sample to run an if statement and then we do another texture sample inside that x statement.

We have to wait twice. Because we have to wait once before doing the if statement. And we have to wait again before using the value from the second texture sample. So that's two serial texture accesses for a total of twice the latency.

Now here's an example of a false dependency. It looks a lot like the other, except we're not using a in the if statement.

But typically, we can't wait across control flow. The if statement acts an effective barrier in this case. So, we automatically have to wait here anyways even though there's no data dependency. So we still get twice the latency. As you noticed the GPU does not actually care about your data dependencies. It only cares about what the dependencies appear to be and so the second one will be just as long latency as the first one, even though there isn't a data dependency there.

And then finally here's a simple one where you just have two texture reads at the top, and they can both be done in parallel and then we can have a single wait. So it's 1 x instead of 2 x for latency.

So, what are you going to do with this knowledge? So in many real world shaders you have opportunities to tradeoff between latency and throughput.

And a common example of this might be that you have some code where based on one texture read you can decide, oh we don't need to do anything in this shader, we're going to quit early. And that can be very useful. Because now all that work that's being done in the cases where you don't need it to be done, you're saving all that work. That's great. But now you're increasing your throughput by reducing the amount of work you need to do.

But you're also increasing your latency because now it has to do the first texture read, then wait for that texture read, then do your early termination check, and then do whatever other texture reads you have. And well is it faster? Is it not? Often you just have to test. Because which is faster is really going to depend on your shader, but it's a thing worth being aware of that often is a real tradeoff and you often have to experiment to see what's right.

Now, while there isn't a universal rule, there is one particular guideline I can give for A8 and later GPUs and that is typically the hardware needs at least two texture reads at a time to get full ability to hide latency. One is not enough.

If you have to do one, no problem. But if you have some choice in how you arrange your texture reads in your shader, if you allow it to do at least two at a time, you may get better performance.

So, in summary.

Make sure you pick the correct address spaces, data structures, layouts and so forth, because getting this wrong is going to hurt so much that often none of the other stuff in the presentation will matter.

Work with the compiler. Write what you mean.

Don't try to be too clever, or the compiler won't know what you mean and will get lost, and won't be able to do its job.

Plus, it's easier to write what you mean.

Keep an eye out for the big pitfalls, not just the micro-optimizations. They're often not as obvious, and they often don't come up as often, but when they do, they hurt. And they will hurt so much that no number of micro-optimizations will save you.

And feel free to experiment. There's a number of rule tradeoffs that happen, where there's simply no single rule. And try them both, see what's faster.

So, if you want more information, go online. The video of the talk will be up there. Here are the other session if you missed them earlier, again, the videos will be online.

Thank you.