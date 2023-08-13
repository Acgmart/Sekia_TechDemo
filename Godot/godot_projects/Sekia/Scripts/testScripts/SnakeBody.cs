using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Snake;

public partial class SnakeBody : Sprite2D
{
	[Signal]
	public delegate void GameOverEventHandler();

	private double _time = 0;
	private enum Direction
	{
		LEFT,
		RIGHT,
		UP,
		DOWN
	};

	private Direction _direction;
	private List<Rect2> _body;
	private bool _eat = false;
	private bool _crash = false;
	public override void _Ready()
	{
		_direction = Direction.RIGHT;
		_body = new List<Rect2>
		{
			new Rect2(0, 0, 40, 40),
			new Rect2(40, 0, 40, 40)
		};
		ZIndex = 1;
	}

	public override void _Draw()
	{
		var color = new Color(0, 1, 0);
		foreach (var rect in _body)
		{
			DrawRect(new Rect2(rect.Position.X + 2, rect.Position.Y + 2, 36, 36), color);
		}
	}

	public bool TryEat(Apple apple)
	{
		if (_body[0].Position.X == apple.Position.X && _body[0].Position.Y == apple.Position.Y)
		{
			GD.Print("Eat Apple!");
			_eat = true;
		}
		return _eat;
	}

	public bool Crash()
	{
		return _body.Skip(1).Any(t =>
		{
			return t.Position.X == _body[0].Position.X && t.Position.Y == _body[0].Position.Y;
		});
	}

	public override void _Process(double delta)
	{
		_time += delta;
		if (_time > 0.5)
		{
			var translation = _direction switch
			{
				Direction.RIGHT => new Vector2(40, 0),
				Direction.LEFT => new Vector2(-40, 0),
				Direction.UP => new Vector2(0, -40),
				_ => new Vector2(0, 40),
			};
			if (_body.Count > 0)
			{
				var newRect = new Rect2(_body[0].Position, _body[0].Size);
				newRect.Position += translation;
				if (newRect.Position.X < 0)
				{
					newRect.Position = new Vector2(600, newRect.Position.Y);
				}
				if (newRect.Position.X > 600)
				{
					newRect.Position = new Vector2(0, newRect.Position.Y);
				}
				if (newRect.Position.Y < 0)
				{
					newRect.Position = new Vector2(newRect.Position.X, 320);
				}
				if (newRect.Position.Y > 320)
				{
					newRect.Position = new Vector2(newRect.Position.X, 0);
				}

				_body.Insert(0, newRect);
				if (!_eat)
				{
					_body.RemoveAt(_body.Count - 1);
				}
				if (Crash())
				{
					GD.Print("CRASH! Game Over");
					_crash = true;
					EmitSignal(SignalName.GameOver);
				}
			}
			if (!_crash)
			{
				QueueRedraw();
			}
			_eat = false;
			_time = 0;
		}
	}

	public override void _Input(InputEvent @event)
	{
		if (@event.IsAction("ui_left") && _direction != Direction.RIGHT)
		{
			_direction = Direction.LEFT;
			return;
		}
		if (@event.IsAction("ui_right") && _direction != Direction.LEFT)
		{
			_direction = Direction.RIGHT;
			return;
		}
		if (@event.IsAction("ui_up") && _direction != Direction.DOWN)
		{
			_direction = Direction.UP;
			return;
		}
		if (@event.IsAction("ui_down") && _direction != Direction.UP)
		{
			_direction = Direction.DOWN;
			return;
		}
	}
}
