class_name Main extends Node2D

var valid_cells = [] # all interactable tiles on the grid

# getters
var player_nodes:
	get: return get_tree().get_nodes_in_group("Players")
var counter_tiles:
	get: return tiles.get_used_cells_by_id(0, 0, Vector2i.ZERO)

@onready var tiles = $TileMap


func _ready():
	# give all players a reference to this main scene
	for player in player_nodes:
		player.main = self
	
	# list all interactable tiles as valid cells
	for tile in counter_tiles:
		valid_cells.append(tile)

func cell_is_valid(cell : Vector2i) -> bool: # if cell is interactable
	return cell in valid_cells
