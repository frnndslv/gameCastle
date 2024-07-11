extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tile_mouse_position: Vector2i = local_to_map(get_global_mouse_position())
	var source_id_from_tile_map: int = get_cell_source_id(0, tile_mouse_position)
	var array_of_used_cells = get_used_cells(0)
	
	if tile_mouse_position:
		for index in array_of_used_cells.size():
			var source_id_without_mouse: int = get_cell_source_id(0, array_of_used_cells[index])
			if source_id_without_mouse == 1 && array_of_used_cells[index] != tile_mouse_position:
				print(array_of_used_cells[index])
				print(tile_mouse_position)
				set_cell(0, array_of_used_cells[index], 0, Vector2i(6,4))
			if source_id_from_tile_map >= 0:
				if source_id_from_tile_map == 0:
					set_cell(0, tile_mouse_position, 1, Vector2i(6,4))
		
