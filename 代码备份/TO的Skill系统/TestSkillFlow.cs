using ETModel.Skill;

namespace ETModel
{
    [ObjectSystem]
    public class TestSkillFlowUpdate: UpdateSystem<TestSkillFlow>
    {
        public override void Update(TestSkillFlow self)
        {
            self.Update();
        }
    }

    public class TestSkillFlow:Component
    {
        private SkillFlow flow;
        public void Init()
        {
            flow = new SkillFlow();
            LogNode node1 = new LogNode() {Name = "node1",StartTime = 0,LogStr = "001"};
            LogNode node2 = new LogNode() {Name = "node2",StartTime = 1000,TotalTime = 1000,LogStr = "002"};
            LogNode node3 = new LogNode() {Name = "node3",StartTime = 2000,LogStr = "003"};
            flow.Nodes.Add(node1);
            flow.Nodes.Add(node2);
            flow.Nodes.Add(node3);
            
            flow.Init();
            // flow.Blackboard.SetVar<string>("a","哈哈哈哈");
            // node3.LogStr = node3.Blackboard.GetVar<string>("a");
            flow.Start(TimeHelper.Now());
        }
        public void Update()
        {
            flow?.Update(TimeHelper.Now());
        }
    }
}