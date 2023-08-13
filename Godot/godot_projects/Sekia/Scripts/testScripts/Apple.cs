using Godot;
using System;

namespace Snake;

public partial class Apple : Sprite2D
{
	/// <summary>
	/// Draws the "apple".
	/// <para>Instead of DrawCircle we could use a Texture inside Godot IDE.</para>
	/// </summary>
	public override void _Draw()
	{
		DrawCircle(new Vector2(20, 20), 15, new Color(0, 1, 0));
		GD.Print($"New Apple Position: {Position}");
	}
}
