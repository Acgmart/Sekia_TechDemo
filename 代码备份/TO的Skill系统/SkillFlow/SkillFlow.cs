using System.Collections.Generic;
using System.Linq;

namespace ETModel.Skill
{
    public class SkillFlow: IReference
    {
        //类型ID
        public int TypeID;
        //唯一ID
        public long ID;
        //开始执行的时间
        public long StartTime { get; private set; }

        //当前一共运行的时间
        public long Time { get; private set; }
        
        //是否开始
        public bool Started { get; private set;}

        //是否结束
        public bool Finished { get; private set; }

        //黑板
        public Blackboard Blackboard;
        
        //所有Nodes
        public List<SkillFlowNode> Nodes = new List<SkillFlowNode>();

        //等待的节点
        public LinkedList<SkillFlowNode> WaitNodes = new LinkedList<SkillFlowNode>();

        //活跃的节点 加进来走Tick
        public LinkedList<SkillFlowNode> ActiveNodes = new LinkedList<SkillFlowNode>();

        public void Init()
        {
            Started = false;

            Blackboard = ReferencePool.Acquire<Blackboard>();
            ActiveNodes.Clear();
            //初始化节点
            foreach (var node in Nodes)
            {
                node.Init(this);
            }

            //节点按开始时间排序
            Nodes.Sort((x, y) =>
            {
                if (x.StartTime == y.StartTime)
                {
                    return 0;
                }
                else if (x.StartTime > y.StartTime)
                {
                    return 1;
                }
                else
                {
                    return -1;
                }
            });

            foreach (var node in Nodes)
            {
                WaitNodes.AddLast(node);
            }
        }

        public void Start(long timeNow)
        {
            StartTime = timeNow;
            Started = true;
            Finished = false;
        }

        public void Finish()
        {
            if (Finished)
            {
                return;
            }

            Finished = true;
            Log.Warning("SkillFlow Finish");
        }

        public void Update(long timeNow)
        {
            if (Finished&&Started==false)
            {
                return;
            }

            //更新时间
            Time = timeNow - this.StartTime;
            ActivateNode(timeNow);
            ActiveNodeTick(timeNow);
            CheckFinish();
        }

        //激活节点
        private void ActivateNode(long timeNow)
        {
            LinkedListNode<SkillFlowNode> cur = WaitNodes.First;
            while (cur != null)
            {
                LinkedListNode<SkillFlowNode> next = cur.Next;
                SkillFlowNode node = cur.Value;
                if (Time >= node.StartTime)
                {
                    //从链表中移除
                    this.WaitNodes.Remove(cur);
                    //节点开始时间赋值
                    node.RealStartTime = timeNow;
                    //加入活跃队伍
                    ActiveNodes.AddLast(node);
                }

                cur = next;
            }
        }

        //激活的节点轮询
        private void ActiveNodeTick(long timeNow)
        {
            LinkedListNode<SkillFlowNode> cur = this.ActiveNodes.First;
            while (cur != null)
            {
                LinkedListNode<SkillFlowNode> next = cur.Next;
                SkillFlowNode node = cur.Value;

                //节点开始 只会执行一次
                node.Start();

                //判定节点结束
                if (this.Time >= node.StartTime + node.TotalTime)
                {
                    //移除
                    this.ActiveNodes.Remove(cur);
                    node.Finish();
                }
                else
                {
                    node.Tick(timeNow);
                }

                cur = next;
            }
        }

        private void CheckFinish()
        {
            if (WaitNodes.Count == 0 && ActiveNodes.Count == 0)
            {
                Finish();
            }
        }

        public void Clear()
        {
            ReferencePool.Release(this.Blackboard);
            this.Blackboard = null;
        }

        public void Dispose()
        {
            
        }
    }
}