using Godot;
using System;
using System.Timers;

namespace Snake;

public partial class Snake : Node2D
{
	// We could use a Godot Timer too.
	private System.Timers.Timer timer;
	// To generate random numbers.
	private static readonly Random rnd = new();
	private int _snakeBodySize;
	private Vector2I _gameSize;

	// Scenes
	private Apple _apple;
	private SnakeBody _snakeBody;
	public override void _Ready()
	{
		_snakeBodySize = 40;
		_gameSize = new(15, 8);

		_snakeBody = GetNode<SnakeBody>("SnakeBody");
		_snakeBody.Position = new Vector2(0, 0);

		_apple = GetNode("Apple") as Apple;
		_apple.Position = new Vector2(
			rnd.Next(_gameSize.X) * _snakeBodySize,
			rnd.Next(_gameSize.Y) * _snakeBodySize);

		timer = new System.Timers.Timer(10000);
		timer.Elapsed += NewApple;
		timer.AutoReset = true;
		timer.Start();

		// We connect to the SnakeBody's GameOver Signal using C# 
		// Lambda expression works too.
		_snakeBody.GameOver += OnGameOver;
	}

	public override void _Process(double delta)
	{
		if (_apple is not null)
		{
			if (_snakeBody.TryEat(_apple))
			{
				RemoveChild(_apple);
				_apple = null;
			}
		}
	}

	public void OnGameOver()
	{
		timer.Stop();
		if (_apple is not null)
		{
			RemoveChild(_apple);
		}
	}

	public void NewApple(object src, ElapsedEventArgs e)
	{
		if (_apple is not null)
		{
			RemoveChild(_apple);
		}
		_apple = new Apple
		{
			Position = new Vector2(rnd.Next(0, 15) * 40, rnd.Next(0, 8) * 40)
		};
		AddChild(_apple);
	}

}
