using Godot;

public partial class Jogador : CharacterBody2D
{
	[Export]
	public int Speed { get; set; } = 400;

	private Vector2 _target;

	public override void _Input(InputEvent @event)
	{
		//GD.Print("Foi");
		if (@event.IsActionPressed("LeftClick"))
		{
			_target = GetGlobalMousePosition();
			
		}
	}

	public override void _PhysicsProcess(double delta)
	{
		Velocity = Position.DirectionTo(_target) * Speed;
		if (Position.DistanceTo(_target) > 10)
		{
			MoveAndSlide();
		}
	}
}
