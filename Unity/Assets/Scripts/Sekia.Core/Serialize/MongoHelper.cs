using System;
using System.IO;
using MongoDB.Bson;
using MongoDB.Bson.IO;
using MongoDB.Bson.Serialization;
using MongoDB.Bson.Serialization.Serializers;
using System.Collections.Generic;
using MongoDB.Bson.Serialization.Conventions;
using UnityEngine;
using System.Runtime.CompilerServices; //module-initializers

namespace Sekia
{
    public static class MongoHelper
    {
        //https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/proposals/csharp-9.0/module-initializers
        //https://docs.unity3d.com/2022.1/Documentation/Manual/CSharpCompiler.html
        //[ModuleInitializer]
        public static void Init()
        {
            //自动注册IgnoreExtraElements 解决版本迭代字段不兼容的问题
            ConventionPack conventionPack = new ConventionPack { new IgnoreExtraElementsConvention(true) };
            ConventionRegistry.Register("IgnoreExtraElements", conventionPack, type => true);
        }

        public static string ToJson(object obj)
        {
            return obj.ToJson();
        }

        public static string ToJson(object obj, JsonWriterSettings settings)
        {
            return obj.ToJson(settings);
        }

        public static T FromJson<T>(string str)
        {
            return BsonSerializer.Deserialize<T>(str);
        }

        public static object FromJson(Type type, string str)
        {
            return BsonSerializer.Deserialize(str, type);
        }

        public static byte[] ToBson(object obj)
        {
            return obj.ToBson();
        }

        public static void ToBson(object obj, MemoryStream stream)
        {
            using (BsonBinaryWriter bsonWriter = new BsonBinaryWriter(stream, BsonBinaryWriterSettings.Defaults))
            {
                BsonSerializationContext context = BsonSerializationContext.CreateRoot(bsonWriter);
                BsonSerializationArgs args = default(BsonSerializationArgs);
                args.NominalType = typeof(object);
                IBsonSerializer serializer = BsonSerializer.LookupSerializer(args.NominalType);
                serializer.Serialize(context, args, obj);
            }
        }

        public static object FromBson(Type type, byte[] bytes)
        {
            return BsonSerializer.Deserialize(bytes, type);
        }

        public static object FromBson(Type type, byte[] bytes, int index, int count)
        {
            using (MemoryStream memoryStream = new MemoryStream(bytes, index, count))
            {
                return BsonSerializer.Deserialize(memoryStream, type);
            }
        }

        public static object FromBson(object instance, byte[] bytes, int index, int count)
        {
            using (MemoryStream memoryStream = new MemoryStream(bytes, index, count))
            {
                return BsonSerializer.Deserialize(memoryStream, instance.GetType());
            }
        }

        public static object FromBson(object instance, Stream stream)
        {
            return BsonSerializer.Deserialize(stream, instance.GetType());
        }

        public static object FromStream(Type type, Stream stream)
        {
            return BsonSerializer.Deserialize(stream, type);
        }

        public static T FromBson<T>(byte[] bytes)
        {
            using (MemoryStream memoryStream = new MemoryStream(bytes))
            {
                return (T)BsonSerializer.Deserialize(memoryStream, typeof(T));
            }
        }

        public static T FromBson<T>(byte[] bytes, int index, int count)
        {
            return (T)FromBson(typeof(T), bytes, index, count);
        }

        public static T Clone<T>(T t)
        {
            return FromBson<T>(ToBson(t));
        }
    }
}
