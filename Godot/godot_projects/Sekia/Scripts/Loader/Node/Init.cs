using System;
using CommandLine;
using Godot;

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

			//DontDestroyOnLoad(gameObject);

			AppDomain.CurrentDomain.UnhandledException += (sender, e) =>
			{
				Log.Error(e.ExceptionObject.ToString());
			};

			// 命令行参数
			string[] args = "".Split(" ");
			Parser.Default.ParseArguments<Options>(args)
				.WithNotParsed(error => throw new Exception($"命令行格式错误! {error}"))
				.WithParsed((o) => World.Instance.AddSingleton(o));
			Options.Instance.StartConfig = $"StartConfig/Localhost";

			World.Instance.AddSingleton<Logger>().Log = new GodotLogger();
			ETTask.ExceptionHandler += Log.Error;

			World.Instance.AddSingleton<CodeLoader>().Start();
		}

		public override void _Process(double delta)
		{
			TimeInfo.Instance.Update();
			FiberManager.Instance.Update();
		}

		public override void _PhysicsProcess(double delta)
		{
			FiberManager.Instance.LateUpdate();
		}

		public override void _ExitTree()
		{
			GD.Print("Distroy");
		}

		public override void _Notification(int what)
		{
			if (what == NotificationWMCloseRequest)
			{
				World.Instance.Dispose();
			}
		}
	}


}
