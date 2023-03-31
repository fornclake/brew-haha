extends Node2D

var valid_cells = []

@onready var tiles = $TileMap

func _ready():
	for tile in tiles.get_used_cells_by_id(0, 0, Vector2i.ZERO):
		valid_cells.append(tile)
	print(valid_cells)
