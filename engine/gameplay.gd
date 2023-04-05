class_name Main extends Node2D

var map_state = {}

var player_nodes : Array:
	get: return get_tree().get_nodes_in_group("Players")

var item_cells : Array:
	get: return tiles.get_used_cells(0)

@onready var tiles = $TileMap
@onready var valid_cells = tiles.get_used_cells_by_id(1, 0, Vector2i.ZERO)


func _ready():
	# give all players a reference to this main scene
	for player in player_nodes:
		player.main = self
		player.interacted.connect(_interaction.bind(player))
	
	# add all item layer cells to map state
	for item in item_cells:
		var tile_data : TileData = tiles.get_cell_tile_data(0, item)
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
	elif item is Dispenser and item.requires_ingredient.size() == 0:
		player.held_item = item.output


func _held_item_interaction(item_cell : Vector2i, player : Player):
	var item = map_state[item_cell]
	if item is Ingredient:
		if item.can_hold(player.held_item):
			item.add_ingredient(player.held_item)
			player.held_item = null
		elif player.held_item.can_hold(item):
			player.held_item.add_ingredient(_give_item(item_cell))
	elif item is Dispenser and item.can_dispense_to(player.held_item) \
			and not item.output in player.held_item.contents:
		player.held_item.add_ingredient(item.output)


func _give_item(item_cell : Vector2i):
	var item = map_state[item_cell]
	map_state.erase(Vector2i(item_cell))
	tiles.erase_cell(0, Vector2i(item_cell))
	return item


func _take_item(player : Player):
	var item_cell = Vector2i(player.selected_cell)
	map_state[item_cell] = player.held_item
	tiles.set_cell(0, item_cell, 2, player.held_item.atlas_coords)
	player.held_item = null


func item_exists_at(cell : Vector2i):
	return true if map_state.get(cell) else false


func cell_is_valid(cell : Vector2i): # if cell is interactable
	return cell in valid_cells
