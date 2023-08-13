using System;
using System.Threading;
using Godot;
//using CommandLine;
//using UnityEngine;

namespace ET
{
	public partial class Init : Node
	{
		public override void _EnterTree()
		{
			GD.Print("Awake");
		}

		public override void _Ready()
		{
			GD.Print("Start");
		}

		public override void _Process(double delta)
		{
			GD.Print("Update");
		}

		public override void _PhysicsProcess(double delta)
		{
			GD.Print("LateUpdate");
		}

		public override void _ExitTree()
		{
			GD.Print("Distroy");
		}

		public override void _Notification(int what)
		{
			if (what == NotificationWMCloseRequest)
			{
				GD.Print("OnApplicationQuit");
			}
		}

		/*
		private void Start()
		{
			DontDestroyOnLoad(gameObject);
			
			AppDomain.CurrentDomain.UnhandledException += (sender, e) =>
			{
				Log.Error(e.ExceptionObject.ToString());
			};

			// 命令行参数
			string[] args = "".Split(" ");
			Parser.Default.ParseArguments<Options>(args)
				.WithNotParsed(error => throw new Exception($"命令行格式错误! {error}"))
				.WithParsed((o)=>World.Instance.AddSingleton(o));
			Options.Instance.StartConfig = $"StartConfig/Localhost";
			
			World.Instance.AddSingleton<Logger>().Log = new UnityLogger();
			ETTask.ExceptionHandler += Log.Error;
			
			World.Instance.AddSingleton<CodeLoader>().Start();
		}

		private void Update()
		{
			TimeInfo.Instance.Update();
			FiberManager.Instance.Update();
		}

		private void LateUpdate()
		{
			FiberManager.Instance.LateUpdate();
		}

		private void OnApplicationQuit()
		{
			World.Instance.Dispose();
		}
		*/
	}


}
