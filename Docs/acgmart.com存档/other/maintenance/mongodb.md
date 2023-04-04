---
title: 非关系型数据库-MongoDB
categories:
- [其他, 运维]
date: 2018-08-24 01:03:16
---
本篇将描述服务端上MongoDB的简单使用,包括基础的安装和连接数据库,对数据的增删查改等. 
选择MongoDB是为了以后和ET服务端框架进行对接，开发环境是Centos7。
参考文章：[Install MongoDB Community Edition on Red Hat Enterprise or CentOS Linux](https://docs.mongodb.com/master/tutorial/install-mongodb-on-red-hat/#install-mongodb-community-edition-on-red-hat-enterprise-or-centos-linux "Install MongoDB Community Edition on Red Hat Enterprise or CentOS Linux")

# 安装MongoDB
先创建一个repo文件
vim /etc/yum.repos.d/mongodb-org-5.0.repo
--------------编辑内容 按I键进入编辑
```
[mongodb-org-5.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/5.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-5.0.asc
```
 --------------编辑完成 按ESC键退出编辑 :wq 回车 --------------
安装MongoDB：yum install -y mongodb-org
可指定组件和版本号：yum install -y mongodb-org-server-5.0.8
安装后自带开机启动 但是不会立刻运行

# 设置程序监听IP（可选）
vim /etc/mongod.conf
设置bindIp: 0.0.0.0 使其监听全IPv4
用途：可以通过windows上运行图形化工具访问Linux上的数据库

## 运行状态确认
service mongod status
默认端口：27017
数据保存地址:/var/lib/mongo/
日志保存地址:/var/log/mongodb/mongod.log
用户名:mongod
配置文件:/etc/mongod.conf

启动MongoDB：service mongod start
停止MongoDB：service mongod stop
重启MongoDB：service mongod restart

# 图形工具访问数据库
图形工具很多，这里我推荐MongoDB Compass。
[官网下载地址](https://www.mongodb.com/download-center#compass "官网下载地址").
运行程序后开始连接到服务器上的数据库，编辑替换URI字符串。

# C#程序支持
图形工具远程连接成功后,可以在界面上随便捣腾一下,但是对于新手来说过于缺乏目标. 
而且我们最终会在.NET Core平台上,使用C#程序去读写数据库,图形化工具主要用来整体观察 
接下来就是在VS中操作了

## 安装MongoDB的C#版驱动
这里我们参考MongoDB的[C#驱动说明页](https://docs.mongodb.com/ecosystem/drivers/csharp/ "C#驱动说明页").
在安装方式中,官方提供2种方式,Nuget安装(Nuget Installation)和编译安装(Binary Installation),并推荐使用Nuget.

## Nuget安装
使用Nuget是最简单的安装驱动方式,一共有5个包可以在nuget上获得,其中MongoDB.Driver是我们需要的. 
MongoDB.Driver:新驱动,在新项目中使用. 
MongoDB.Driver.Core:驱动的核心,MongoDB.Driver的依赖之一,你可能不会直接用上这个包. 
MongoDB.Driver.Bson:MongoDB.Driver的依赖之一.
    Bson是Binary JSON的简称，是一种类Json的二进制存储格式,使用于存储数据和网络数据交换. 

## 编译安装
地址：https://github.com/mongodb/mongo-csharp-driver

# MongoDB的C#入门程序
```Csharp
using System;
using MongoDB.Driver;
using MongoDB.Bson;
using MongoDB.Driver.Linq;
using System.Linq;

namespace mongodbtest
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            //连接到本地MongoDB服务
            var client = new MongoClient();
            //var client = new MongoClient("mongodb://localhost:27017");
            //client实例将在数据库间建立一个连接池

            //卸载指定数据库
            client.DropDatabase("foo");
            Console.WriteLine("删除了数据库foo");

            //建立一个Database
            var database = client.GetDatabase("foo");
            Console.WriteLine("创建了数据库foo");
            //使用client的GetDatabase方法获取指定名称的数据库
            //如果指定数据库不存在 则创建该数据库

            //创建一个Collection
            var collection = database.GetCollection<BsonDocument>("bar");
            //如果指定Collection不存在 则创建该集合
            //collection对应在数据库foo中的bar集合

            //创建一个BsonDocument
            var documentNew = new BsonDocument
            {
                {"name","MongoDB" },
                {"type","Datebase" },
                {"count",1 },
                {"info",new BsonDocument
                    {
                        {"x",203 },
                        {"y",102 }
                    }
                }
            };

            //将一个BsonDocument插入到一个集合中
            collection.InsertOne(documentNew);
            //可以使用异步方法InsertOneAsync()
            //await collection.InsertOneAsync(document);
            //提示await运算符只能用于异步方法中:为所在方法添加修饰符async
            //static void Main(string[] args)  入口方法不能加入async
            //驱动中包含丰富的异步特性
            //所有的方法都包括同步和异步版本

            //创建12个BsonDocument 并插入
            var documentsNew = Enumerable.Range(2, 12).Select(i => new BsonDocument("counter", i));
            collection.InsertMany(documentsNew);
            //await collection.InsertManyAsync(documents);

            //计算Document数量
            var count = collection.CountDocuments(new BsonDocument());
            Console.WriteLine("文档数为"+count);
            //var countAsync = await collection.CountDocumentsAsync(new BsonDocument());
            //new BsonDocument() 作为CountDocumentsAsync方法的filter(过滤器)
            //在本例中使用空的BsonDocument来计算全部文档

            //查询(Query)集合
            //使用Find方法查询集合
            //Find方法返回一个IFindFlunt<TDocument,TProjection>实例
            //该实例提供一个流接口,用于把查询操作链接起来

            //找到集合中的第一个文档
            //返回第一个文档或者null
            var documentFind = collection.Find(new BsonDocument()).FirstOrDefault();
            //Console.WriteLine(documentFind.ToString());
            //var documentFindAsync = await collection.Find(new BsonDocument()).FirstOrDefaultAsync();
            //Console.WriteLine(documentFindAsync.ToString());
            //本例中应返回以下文档:
            //{ "_id" : ObjectId("5b8e6603adaf4c1b7808e1bb"), "name" : "MongoDB", "type" : "Datebase", "count" : 1, "info" : { "x" : 203, "y" : 102 } }
            //在图形工具中也可以同步查看
            //"id"元素被自动添加
            //以"_"和"$"开头的名称为MongoDB内部使用

            //找到集合中的全部文档
            var documentsAll = collection.Find(new BsonDocument()).ToList();
            //var documentsAllAsync = await collection.Find(new BsonDocument()).ToListAsync();
            //如果文档数量不大的话可以使用本方法 将返回一个文档列表
            //如果文档数量相当大,可以使用ForEachAsync方法,每返回一个文档打印一条消息
            //await collection.Find(new BsonDocument()).ForEachAsync(d => Console.WriteLine(d));
            //使用同步方法读取每一个文档
            var cursor = collection.Find(new BsonDocument()).ToCursor();
            foreach(var doc in cursor.ToEnumerable())
            {
                Console.WriteLine("打印全部"+doc);
            }
            //会将从第1个到第13个文档一次打印一遍

            //使用Filter获得单个文件
            //创建一个过滤器并传递给Find方法来获得一个collection的子集
            //下面的例子将返回查找到的字段counter值为7的第一个文档
            var filter1 = Builders<BsonDocument>.Filter.Eq("counter", 7);
            var document1 = collection.Find(filter1).First();
            Console.WriteLine("打印7号"+document1);
            //FirstAsyc()

            //使用Filter获得一堆文档
            //如果我们想得到所有counter>10的文档:
            var filter2 = Builders<BsonDocument>.Filter.Gt("counter", 10);
            var cursor2 = collection.Find(filter2).ToCursor();
            foreach(var doc in cursor2.ToEnumerable())
            {
                Console.WriteLine("打印大于10"+doc);
            }
            //ForEachAsync()

            //我们也可以设置一个范围,如5<counter<=8
            var filterBuilder = Builders<BsonDocument>.Filter;
            var filter3 = filterBuilder.Gt("counter", 5) & filterBuilder.Lte("counter", 8);
            var cursor3 = collection.Find(filter3).ToCursor();
            foreach(var doc in cursor3.ToEnumerable())
            {
                Console.WriteLine("打印范围内"+doc);
            }

            //整理文档
            //可以使用Sort方法添加一个排序用来查找.
            //下面的例子使用了Exists过滤器,和Descending排序方法来整理文档
            var filter4 = Builders<BsonDocument>.Filter.Exists("counter");
            var sort = Builders<BsonDocument>.Sort.Descending("counter");
            var document4 = collection.Find(filter4).Sort(sort).First();
            Console.WriteLine("降序第一" + document4);

            //获取指定字段
            //我们通常并不需要文档的全部数据,而是只需要其中的某些字段
            //使用Projection为查找操作创建prpjection元素
            //下面的例子将输出首个文档,用Exclud方法不显示文档的_id字段
            var projection1 = Builders<BsonDocument>.Projection.Exclude("_id");
            var document5 = collection.Find(new BsonDocument()).Project(projection1).First();
            Console.WriteLine("不显示_id字段" + document5);

            var projection2 = Builders<BsonDocument>.Projection.Include("count");
            document5 = collection.Find(new BsonDocument()).Project(projection2).First();
            Console.WriteLine("只显示count字段" + document5);

            var projection3 = Builders<BsonDocument>.Projection.Include("counter");
            document5 = collection.Find(new BsonDocument()).Project(projection3).First();
            Console.WriteLine("只显示counter字段" + document5);

            //修改文档
            //下面的例子将修改第一个匹配到的,符合counter==10的文档,并设置i值为110;
            var filter6 = Builders<BsonDocument>.Filter.Eq("counter", 10);
            var update6 = Builders<BsonDocument>.Update.Set("counter", 110);
            collection.UpdateOne(filter6, update6);
            //批量修改文档只需使用UpdateMany/UpdateManyAsync

            //查找counter<4的字段,使counter=counter+100
            var filter7 = Builders<BsonDocument>.Filter.Lt("counter", 4);
            var update7 = Builders<BsonDocument>.Update.Inc("counter", 100);
            var result = collection.UpdateMany(filter7, update7);
            if(result.IsModifiedCountAvailable)
            {
                Console.WriteLine("成功修改条数"+result.ModifiedCount);
            }
            //UpdateResult提供update的结果,包括被修改的文档数

            cursor = collection.Find(new BsonDocument()).ToCursor();
            foreach (var doc in cursor.ToEnumerable())
            {
                Console.WriteLine("打印全部" + doc);
            }


            //删除文档
            //删除一个文档
            var filter8 = Builders<BsonDocument>.Filter.Eq("counter", 7);
            collection.DeleteOne(filter8);
            //使用DeleteMany删除多个文档
            var filter9 = Builders<BsonDocument>.Filter.Gte("counter", 5);
            var result9 = collection.DeleteMany(filter9);
            Console.WriteLine("删除了的条数:"+result9.DeletedCount);
            //DeleteResult提供关于操作的信息,包括被删除文档数

            cursor = collection.Find(new BsonDocument()).ToCursor();
            foreach (var doc in cursor.ToEnumerable())
            {
                Console.WriteLine("批量删除后还剩" + doc);
            }

            //区块写
            //有两种bulk operation
            //1.有序区块操作
            //2.无序区块操作
            var models = new WriteModel<BsonDocument>[]
            {
                new InsertOneModel<BsonDocument>(new BsonDocument("_id",1)),
                new InsertOneModel<BsonDocument>(new BsonDocument("_id",2)),
                new InsertOneModel<BsonDocument>(new BsonDocument("_id",3)),
                new UpdateOneModel<BsonDocument>(
                    new BsonDocument("_id",1),
                    new BsonDocument("$set",new BsonDocument("x",2))),
                new DeleteOneModel<BsonDocument>(new BsonDocument("_id",3)),
                new ReplaceOneModel<BsonDocument>(
                    new BsonDocument("_id",3),
                    new BsonDocument("_id",3).Add("x",4))
            };

            //1.有序区块操作实例,操作顺序是保障的
            collection.BulkWrite(models);

            //2.无序区块操作实例,没有保障操作顺序
            //这里我其实没有看懂,可以做修改测试如连续修改某个值10次,看操作顺序对结果的影响
            //collection.BulkWrite(models, new BulkWriteOptions { IsOrdered = false });

            cursor = collection.Find(new BsonDocument()).ToCursor();
            foreach (var doc in cursor.ToEnumerable())
            {
                Console.WriteLine("最终结果" + doc);
            }
        }
    }
}
```