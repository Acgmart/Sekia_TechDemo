namespace ET
{
    public abstract class Object
    {
        public override string ToString()
        {
            //return MongoHelper.ToJson(this);
            return null;
        }
        
        public string ToJson()
        {
            //return MongoHelper.ToJson(this);
            return null;
        }
        
        public byte[] ToBson()
        {
            //return MongoHelper.Serialize(this);
            return null;
        }
    }
}