namespace ETModel.Skill
{
    public abstract class SkillFlowNode
    {
        public SkillFlow SkillFlow { get; private set; }

        public Blackboard Blackboard { get; private set; }

        //节点在技能流中的开始时间
        public long StartTime;

        //节点开始时间 真实时间
        public long RealStartTime;

        //此节点持续的时间
        public int TotalTime;

        public string Name;

        //是否执行过Start
        private bool started;

        //是否已经完成
        public bool Finished { get; private set; }

        //初始化
        public virtual void Init(SkillFlow flow)
        {
            this.SkillFlow = flow;
            Blackboard = flow.Blackboard;
            this.Finished = false;
            this.started = false;
        }

        //执行
        public void Start()
        {
            if (this.started)
            {
                return;
            }

            this.OnStart();
            this.started = true;
        }

        //每帧
        public void Tick(long timeNow)
        {
            this.OnTick(timeNow);
        }

        //结束
        public void Finish()
        {
            if (this.Finished)
            {
                return;
            }

            Log.Warning($"Node:{this.Name} Finish");
            this.OnFinish();
            this.Finished = true;
        }

        public virtual void OnStart()
        {
        }

        public virtual void OnTick(long timeNow)
        {
        }

        public virtual void OnFinish()
        {
        }
    }
}