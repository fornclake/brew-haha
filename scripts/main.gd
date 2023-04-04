class_name Main extends Node2D

const ITEM_LAYER = 0
const COUNTER_LAYER = 1

var valid_cells = [] # all interactable tiles on the grid
var map_state = {}

# getters
var player_nodes : Array:
	get: return get_tree().get_nodes_in_group("Players")

var counter_cells : Array:
	get: return tiles.get_used_cells_by_id(COUNTER_LAYER, 0, Vector2i.ZERO)

var item_cells : Array:
	get: return tiles.get_used_cells(ITEM_LAYER)

@onready var tiles = $TileMap


func _ready():
	# give all players a reference to this main scene
	for player in player_nodes:
		player.main = self
		player.interacted.connect(_interaction.bind(player))
	
	# list all interactable tiles as valid cells
	for tile in counter_cells:
		valid_cells.append(tile)
	
	# add all item layer cells to map state
	for item in item_cells:
		var tile_data : TileData = tiles.get_cell_tile_data(ITEM_LAYER, item)
		tile_data.set_custom_data("Item", tile_data.get_custom_data("Item").duplicate())
		map_state[item] = tile_data.get_custom_data("Item")


func _interaction(item_cell, player : Player):
	item_cell = Vector2i(item_cell)
	
	if player.held_item:
		if item_exists_at(item_cell):
			_held_item_interaction(item_cell, player)
		else:
			_take_item(player)
	elif item_exists_at(item_cell):
		_item_interaction(item_cell, player)

func _item_interaction(item_cell : Vector2i, player : Player):
	var item = map_state[item_cell]
	if item is Ingredient:
		player.held_item = _give_item(item_cell)
	elif item is Dispenser:
		player.held_item = item.output

func _held_item_interaction(item_cell : Vector2i, player : Player):
	var item = map_state[item_cell]
	if item is Ingredient:
		if item.can_hold(player.held_item):
			item.add_ingredient(player.held_item)
			player.held_item = null
		elif player.held_item.can_hold(item):
			player.held_item.add_ingredient(_give_item(item_cell))


func _give_item(item_cell : Vector2i):
	var item = map_state[item_cell]
	map_state.erase(Vector2i(item_cell))
	tiles.erase_cell(ITEM_LAYER, Vector2i(item_cell))
	return item


func _take_item(player : Player):
	var item_cell = Vector2i(player.selected_cell)
	map_state[item_cell] = player.held_item
	tiles.set_cell(ITEM_LAYER, item_cell, player.held_item.tile_source_id, Vector2i.ZERO)
	player.held_item = null


func item_exists_at(cell : Vector2i):
	return true if map_state.get(cell) else false


func cell_is_valid(cell : Vector2i): # if cell is interactable
	return cell in valid_cells
