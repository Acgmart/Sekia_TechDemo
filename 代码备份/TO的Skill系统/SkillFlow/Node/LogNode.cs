namespace ETModel.Skill
{
    public class LogNode: SkillFlowNode
    {
        public string LogStr;

        public override void OnStart()
        {
            Log.Warning(this.LogStr);
        }
    }
}