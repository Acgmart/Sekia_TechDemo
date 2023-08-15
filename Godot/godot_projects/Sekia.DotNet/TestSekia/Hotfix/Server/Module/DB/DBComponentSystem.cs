using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace ET.Server
{
    [EntitySystemOf(typeof(DBComponent))]
    [FriendOf(typeof(DBComponent))]
    public static partial class DBComponentSystem
    {
        [EntitySystem]
        private static void Awake(this DBComponent self, string dbConnection, string dbName, int zone)
        {
        }
    }
}
