extends Node2D

@onready var tileMap = $"../TileMap"

var astarGrid: AStarGrid2D
var currentIdPath: Array[Vector2i]
var currentPointPath: PackedVector2Array
var targetPosition: Vector2
var isMoving: bool

func _ready():
	astarGrid = AStarGrid2D.new()
	astarGrid.region = tileMap.get_used_rect()
	astarGrid.cell_size = Vector2(445, 320)
	astarGrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astarGrid.update()
	
	for x in tileMap.get_used_rect().size.x:
		for y in tileMap.get_used_rect().size.y:
			var tilePosition = Vector2i(
				x + tileMap.get_used_rect().position.x,
				y + tileMap.get_used_rect().position.y
			)
			
			var tileData = tileMap.get_cell_tile_data(0, tilePosition)
			
			#if tileData == null or tileData.get_custom_data()
			
			
func _input(event):
	if event.is_action_pressed("LeftClick") == false: 
		return
	
	var idPath
	
	if isMoving:
		idPath = astarGrid.get_id_path(
			tileMap.local_to_map(targetPosition),
			tileMap.local_to_map(get_global_mouse_position())
		)
	else:
		idPath = astarGrid.get_id_path(
			tileMap.local_to_map(global_position),
			tileMap.local_to_map(get_global_mouse_position())
		).slice(1)
		
	if idPath.is_empty() == false:
		currentIdPath = idPath
		
		currentPointPath = astarGrid.get_point_path(
			tileMap.local_to_map(targetPosition),
			tileMap.local_to_map(get_global_mouse_position())
		)
		
		for i in currentPointPath.size():
			currentPointPath[i] = currentPointPath[i] + Vector2(222, 160)
		
		
func _physics_process(delta):
	if currentIdPath.is_empty():
		return
		
	if isMoving == false:
		targetPosition = tileMap.map_to_local(currentIdPath.front())
		isMoving = true
		
	global_position = global_position.move_toward(targetPosition, 1)
	
	if global_position == targetPosition:
		currentIdPath.pop_front()
		
		if currentIdPath.is_empty() == false:
			targetPosition = tileMap.map_to_local(currentIdPath.front())
		else:
			isMoving = false
