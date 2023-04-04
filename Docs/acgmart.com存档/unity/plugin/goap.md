---
title: GOAP入门
categories:
- [Unity, 插件]
date: 2020-06-06 23:30:29
---

\[toc\]本篇描述Goal-Oriented Action Planning(简称GOAP)。 参考资料： ReGoap：`https://github.com/luxkun/ReGoap` [烟雨的博客](https://www.lfzxb.top/gdc-sharing-of-ai-system-based-on-goap-in-fear-simple-cn/?tdsourcetag=s_pctim_aiomsg "烟雨的博客")

# ExampleFSMScene

## MultipleResourcesManager

本篇中，用Plane上的大量mesh来演示资源的概念。 有很多的木材和矿石资源，这些在场景初始化的时候，必须先生成好。 1.资源有不等的初始储蓄量，可以被挖掘消耗，类似于怪物的HP。 2.资源有不同的类型，继承了“资源”接口，在交互逻辑上有相似性。 3.每种资源需要单独管理，比如木材管理组件，告诉工人，哪里有树可以砍伐。

## WorkstationsManager

工作站管理组件，在初始化时描述数个工作站，告诉工人，哪个工作站可用。 1.工作站需要明确用途，在本例中，工作站只有一个用途：合成物品(斧头)。 2.工作站有加工资源的能力，将材料，通过配方，转化为产出物品。 3.默认工作站可以处理任何类型的配方。

## 组件 BankManager

银行管理组件，在初始化时描述数个银行，告诉工人，哪个银行可用。 1.银行使用一个背包组件，实现存储资源的功能。 2.资源从一个背包中转移到银行中。

## 组件 AgentsSpawner

每过一定间隔，实例化prefab，直到指定的实例数。 这里用来生成工人的实例，工人的逻辑都挂载在prefab上。 工人需要等待AI系统加载完成才能干活，参考后面的章节。

## 组件 FSMExamplePlannerManager

所有Planner的管理者，至少需要一个以上的“目标”来驱动执行整个系统。 MultiThread：是否开启多线程计算。 ThreadsCount：指定线程数。每个线程运行一个Planner，执行一个任务队列。 PlannerSettings：Planner设置。 PlanningEarlyExit：是否允许提前跳出 MaxIterations：最大迭代数 MaxNodesToExpand：最大拓扑结点数 UsingDynamicActions：使用动态Action，Action的条件和效果可以动态变化。 DebugPlan：是否启用规划的Debug工具输出。 LogLevel：日志等级 NodeWarmupCount：结点预热个数 StatesWarmupCount：状态预热个数

# papper中的概念精简

## 规划

假设Alma饿了，Alma可以打电话给Domino订购披萨，但前提是他有Domino的电话号码，但披萨并不是她唯一的选择；她也可以烤馅饼，但要有食谱。所以她的`目标`就是不再饥饿。她可以采取两种行动来实现该目标：打电话给Domino或烤馅饼。 如果她目前的世界状态拥有Domino的电话号码，那么她可以制定呼叫Domino的计划，以缓解自己的饥饿感。或者，如果她世界状态有食谱，可以烤馅饼。 如果Alma处于幸运的情况下，她既有电话号码又有食谱，则两种计划都可以满足目标。稍后我们将讨论迫使计划者偏爱一个计划而不是另一个计划的方法。如果Alma没有电话号码或者食谱，那么她很不幸。 这些示例显示了只有一个动作的简单计划，但实际上一个计划可能具有任意数量的动作，这些动作受先决条件和效果的束缚。例如，如果订购披萨店的先决条件是Alma有足够的钱，那么令人满意的计划可能需要先开车到银行。 ![](https://img.acgmart.com/uploads/QQ截图20200419151556.png)

## 动作

动作由其前提和效果定义，比如`订购披萨`这个行为。 `前提`是根据世界状况(object列表)描述的，就像我们定义目标一样(存在不饥饿)。 `效果`是对世界状况的影响(删除了“饥饿”，添加“不饥饿”)。 例如，购买操作向我们拥有的世界状态添加了信息，我们可以购买任意数量的对象，拥有一个对象并不能阻止我们拥有另一个。

## 规划系统的好处

在F.E.A.R中，`目标`是消除威胁，可以通过向敌人开枪来消灭敌人，从而实现目标。 但是，枪需要上膛，或者使用近战攻击，前提是距离足够近。 不同类型的角色(战士/刺客/老鼠)，会使用适合自己的行为，来实现相同的目标。 规划系统的好处： 1.使目标和动作解耦 2.将简单的动作组合产生复杂的(因素驱动的)行为 3.赋予角色动态解决问题的能力 规划系统根据`目标`以及`行为`的`前提`和`效果`，在运行时找出目标和行为之间的依赖关系。 我们向规划系统投入目标和行动，而不必指定这些行为之间的过渡。 ![](https://img.acgmart.com/uploads/QQ截图20200419173904.png) 插入逻辑：AI为了执行行为会尝试满足该行为的前提，从而实现插入逻辑。 优先级：多个可以实现目标计划中，根据行为的权重，选择计划执行。 **State**：定义世界状态，参考`ReGoapState.cs`。 **Action**：定义条件和效果，这些都是AI的可选行为，参考`ReGoapAction.cs`。 例子： 1.开门：{条件:{在门附近:真，门没有上锁:真}，效果:{门打开了:真}} 2.近战攻击：{条件:{装备了武器:真，在敌人附近:真}，效果:{攻击敌人:真}} 注：不能用false描述条件和效果。 注：一般，Action完成时不会记忆效果，可重写Exit方法，添加记忆。 **Goal**：定义为一系列请求，AI的期望效果，。 1.杀敌：{攻击敌人:真} 2.巡逻：{巡逻中:真} **Memory**：AI的记忆库，存储对于AI来说的已知条件。 **Sensor**：AI用于获取世界状态信息的媒介。 **Agent**：AI，代理人。

# Unity中使用ReGoap

1.为AI创建GameObject 2.添加Agent组件(继承自ReGoapAgent或IReGoapAgent接口) 3.添加Memory组件(继承自ReGoapMemory或IReGoapMemory接口) 4.(可选)添加Sensor组件(继承自ReGoapSensor或IReGoapSensor接口) 5.(可选)添加Action组件(继承自ReGoapAction或IReGoapAction接口) Action需明确前提和效果，并重写Run方法。 6.(可选)添加Goal组件(继承自ReGoapGoal或IReGoapGoal接口) Goal需明确目标状态。 7.添加PlannerManager组件(继承自ReGoapPlannerManager) 这是规划的全局配置，单例，用于处理所有规划(内部逻辑入口)。 下面为代码分析理解。

# Core库

**注：本节内容参考Core文件夹下的文件** Core文件中声明的内容为整个AI框架的基础接口。 这部分的代码业务逻辑不明显，只能从方法声明上一窥全貌。

## State

State(状态)是游戏中世界的客观现状，受限于我们想表达的内容，是一个集合概念。 前提、效果、记忆、目标、设置，都是State的表现形式。

### 泛型：ReGoapState<T, W>

T，描述元素类型，比如树、斧头。 W，对该元素的多维度的补充，比如数量、质量之类，用于**对比**。 由于记忆的作用很多，T作为标识符建议用string，W则根据具体作用选择类型。 用于**描述**对象的State： 表示一种资源的集合时：`{string resourceTree, List<ResourcePair> resources}` 这种复杂的描述就不适合与别的State进行对比，只能用于辅助计算条件。 用于**对比**判断的State： 假设目标是：有2棵树，`{string hasTwoTree, bool true}` 当代理人的状态中存在这个元素，表示任务完成了。 对比用State的**错误演示**： `{string hasTwoTree, bool false}` 或者 `{string Tree, int 2}` 在对比时会判定失败，元素不相等等效于元素不存在，不利于业务逻辑。 如果我们修改目标使用int进行描述，也就是代理人拥有3棵树也是失败。 private ConcurrentDictionary<T, W> values; 用线程安全词典存储状态。 private ReGoapState() 自构，声明空的词典；私有的，禁止在外部实例化；只有2个方式实例化： 1.游戏初始化时，根据全局设置中的State预热数，实例化指定数量实例，入栈。 2.Instantiate方法，从预热栈中出栈，或者新建实例。 State之间的集合运算 集合之间可以有交集、并集、补集等运算。 A和B共有的部分，简记A交B； A和B加起来的部分，简记A加B； A中排除B有的部分，简记A减B。 这样看来，很多方法的意图就明显了。 Init(old)：等于操作，返回this。 operator +：加操作，返回新实例。 AddFromState(b)：加操作，修改this实例。 Count：集合内元素的数量。 HasAny(other)：两个集合是否存在交集(元素描述相同)。 HasAnyConflict(other)：检查交集中，是否存在元素的描述差异。 HasAnyConflict(changes, other)：检查差异时，额外考虑changes集合的影响(过滤)。 MissingDifference(other, stopAt)：返回存在差异元素的个数。 MissingDifference(other, difference, stopAt, predicate)：额外将(this的)差异元素写入到difference。 ReplaceWithMissingDifference(other, stopAt, predicate)：额外将(this的)差异元素写入到this。 Clone：等于操作，返回新实例。 Recycle：回收，直接入栈this实例，等再次用到本实例时再自动清空。 ToString：字符串输出集合，用于日志。 Get：查询元素状态。 Set：设置元素状态。 Remove：删除元素。 GetValues：获取全部元素。 TryGetValue：查询元素状态，使用out取值，返回bool。 HasKey：查询元素是否存在。 Clear：清空元素。

## Memory

记忆表示代理人已知的部分世界状态，是一个特殊的State，代理人挂载件。 GetWorldState：获取世界状态，对于代理人来说，他所知道的即全部。 记忆将变为挂载在代理人身上的组件，每个人都有独立的一份记忆。 但是，记忆的初始状态是空的State，需要获取新元素的途径。 protected限制使得只有子级可以修改记忆，或通过感应器、行为等代理人组件修改记忆。

## Sensor

感应器，管理记忆，获取新记忆的媒介。 感应器将变为挂载在代理人身上的组件，每个人都有多种获取信息的方式。 Init：初始化组件(通过记忆组件激活此类组件) 比如：写入初始的元素 GetMemory：获取记忆 UpdateSensor：感应逻辑，更新元素属性。 比如：位置感应器在记忆中写入当前的坐标，以一定周期更新该元素。 **专注于业务** 代理人的记忆需要有特定元素，用于执行其目标，这些都是设计好了的业务逻辑。 **意外性**： 记忆可能出错/过期，当代理人到达本来有资源的坐标时，资源可能被采掘完了。 根据遭遇修复记忆，比如，删除被采掘完了的资源点，尝试其他资源点。 **限制记忆的写入权限** 代理人不应被外力串改记忆，记忆属性始终是受保护的。

## GoapActionStackData

当多个Action组成一个`规划`后，使用该结构体存储`规划的数据`。 规划链上的Action通过这些数据获取前提、效果。 currentState：当前的状态(代理人的记忆) goalState：目标状态 agent：代理人 next：下一个行为 settings：设置

## Action

代理人的可选行为，业务逻辑，代理人挂载件。

### override Precalculations(stackData)

在测试动作可行性前的必要计算，本例中没有Action重写此方法。 理论上可以修改Action的数据，根据业务逻辑需求再考虑是否重写。

### override GetSettings(stackData)

根据代理人的当前状态、目标等，输出执行Action必要的参数。 比如：GatherResourceAction 判断目标中是否有“hasResource”开头的的元素，这意味着代理人目前缺少某种资源； 如果代理人记得在哪里有这种资源，那么就有可能通过Run本动作去推动目标完成; 返回执行动作必要的设置(状态)，如资源点和其坐标。

### override GetPreconditions(stackData)

尝试计算出`前提`，比如：拥有某种资源、在指定的坐标。 比如：GatherResourceAction 收集资源动作的前提是，确定了要收集的目标，且代理人在资源位置上。

### Run(previousAction, nextAction, settings, goalState, done, fail)

执行业务逻辑 PlanEnter(previousAction, nextAction, settings)：规划成立事件 PlanExit(previousAction, nextAction, settings)：规划失败事件 Exit(nextAction)：退出事件(因行为完成、取消) GetName：获取行为名 IsActive：是否处于激活状态 IsInterruptable：是否可中断 AskForInterruption：请求中断 GetEffects(stackData)：获取`效果` GetCost(stackData)：计算权重(值越小越受青睐) CheckProceduralCondition(stackData)：判定前提 ToString(stackData)

## ActionState

关联了一个Action和一个State，可作为一个节点，多个节点构成规划。

## Agent

代理人，AI的执行者，AI框架的驱动者，代理人挂载件。 GetMemory：获取记忆 GetCurrentGoal：获取正在执行的目标 WarnPossibleGoal(goal)：标记一个目标可用 IsActive：是否为激活状态 GetStartingPlan：获取正在启动的规划(节点列表) GetPlanValue(key)：获取规划定义的元素 SetPlanValue(key, value)：添加规划定义的元素 HasPlanValue(target)：规划定义的State中是否包含目标 GetGoalsSet：获取可能的目标列表 默认所有目标都是可用的。 如果一个目标失败了，那么将其添加到黑名单列表，一段时间内不再考虑该目标。 GetActionSet：获取行为列表 InstantiateNewState：实例化一个新的State **初始化** 代理人需要准备好后，进入空闲状态，然后向规划者发起“规划请求”。 这些准备包括：记忆、目标、行为的初始化，这些都是挂载件。

## Goal

规划/代理人的可选目标，代理人挂载件。 **Run**(callback)：运行目标 **GetPlan**：获取规划 **GetName**：获取目标名 本例中的目标：CollectResourceGoal **Precalculations**(goapPlanner)： 进行预计算(`获取必要的信息` 用于判断本目标是否可行) **IsGoalPossible**：本目标是否可能实现 比如：要杀敌 需要判断代理人是否具有攻击手段

### GetGoalState 获取状态

目标的核心是一个State，在组件的Awake中声明： goal.Set("collectedResource" + ResourceName, true); goal.Set("reconcilePosition", true); 这意味着，如果Action的效果能提供这2个元素，目标则可以完成。 **GetPriority**：获取本目标优先级(越大越受青睐) **SetPlan**(path)：设置规划 **GetErrorDelay**：获取错误延迟 **初始化** 目标是一个特殊的State，Awake时应填充初始元素。 运行时并不会修改目标的State，所以，目标可使用Excel批量导出。

# Planner库

**注：本节内容参考Planner文件夹下的文件**

## Planner

`规划者`，用于定制`规划`。 Plan(goapAgent, blacklistGoal, currentPlan, callback)： 根据代理人的目标集合制定一个可行的`规划` 对代理人的全部目标进行`预计算`，筛选出`有可行性的目标列表`。 对有可行性的目标列表，根据优先级从小到大的顺序排列。 GetCurrentGoal：获取当前的目标 GetCurrentAgent：获得当前的代理人 IsPlanning：是否正在规划 GetSettings：获取规划的设置 goapAgent：代理人 currentGoal当前目标 Calculated：是否已计算 astar：规划的路径规则 settings：规划的设置 自构：设置astar、settings **UsingDynamicAction**： 关闭动态行为时： 可通过动作的效果，缩小目标几何的范围；判断记忆和缩小后的范围可以提前得出目标的可行性。

## ReGoapPlannerSettings

规划的设置。 PlanningEarlyExit：是否可以提前跳出 MaxItertions：最大迭代次数 MaxNodesToExpand：最大节点数 UsingDynamicActions：是否使用动态Action DebugPlan：是否启用规划的Debug工具输出

## Node

A星的节点，对应一个Action。 GetState：获取状态 状态表示节点对应的世界状态，比如：初始节点的状态就是代理人的记忆。 Expand：对初始节点进行拓扑 CompareTo：对比 GetCost：获取节点权重(越小越受青睐) GetHeuristicCost：获取启发式权重 目标中的元素数量，某些复杂情况下提高运算速度。 GetPathCost：获取路径权重(越小越受青睐) 从起点开始，累加父级的Action的Cost值。 GetParent；获取父节点 IsGoal：此节点是终点(即达成了Goal的状态) Name：获取名字 Goal：获取目标 Effects：获取影响 Preconditions：获取先决条件 QueueIndex：获取低优先级队列中的值 Priority：优先级(越大越受青睐) Recycle：回收节点 Instantiate：实例化节点，自构和Init均为私有，外部只能调用这个。 创建新节点实例，并Init。

## Astar

A星寻路，用于寻找规划最短路径。 自构(节点最大数量)：Planner专用，使其具有寻路(规划)能力。 Run(start, goal, maxIterations, earlyExit, clearNodes, debugPlan)： 以start为起点，寻找能抵达目标的最短 且 权值最小路径。 如果规划成功，返回Goal节点，否则返回null。 **start节点**： 优先级列表中的第一个元素，以代理人当前记忆为起点，与目标状态之间差距最大。

## FastPriorityQueue

A星寻路专用，高速型`优先级队列`，二叉堆；T是节点，U是State。 二叉堆的特点：从序列1开始算起； 父节点的优先级总是比子节点低(图中没显示优先级)； 父节点的序列值等于子节点的序列值 / 2； 左子节点的序列值等于父节点序列值 \* 2； 右子节点的序列值等于父节点序列值 \* 2 + 1。 ![](https://img.acgmart.com/uploads/77c6a7efce1b9d16836da71efbdeb48f8c546422.png) Enqueue(node, priority)： 向队列中添加一个元素(获得该元素的序列值)，并根据优先级重新整理父子级关系。 如果父级有更高的优先级(节点Cost更小)，则交换父子级的位置(序列值)。 Dequeue：出队并移除序列值为1的节点。 Remove(node)：移除节点并重新排序。 只有最后一个节点可以直接删除，先与之互换位置，移除后向下排序； 向下排序：尽可能把节点移到更低的位置(左下或者右下移动) 最大节点数：避免触发节点数触及上限，Count == MaxSize。