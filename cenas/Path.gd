extends Node2D
@onready var player = $"../Jogador"

func _process(delta):
	queue_redraw()

func _draw():
	if player.currentPointPath.is_empty():
		return
		
	draw_polyline(player.currentPointPath, Color.RED)
