extends CanvasLayer

@export var player : Player
@export var main : Main

var text := "":
	set(value):
		label.text = value
		text = value

@onready var label = $Label

var DIRECTIONS = {Vector2i.LEFT: "Left", Vector2i.RIGHT: "Right", Vector2i.UP: "Up", Vector2i.DOWN: "Down"}


func _process(_delta):
	text = ""
	
	text += "Position: " + str(player.grid_position)
	text += "\nDirection: " + DIRECTIONS[player.orth_direction]
	if player.can_interact:
		text += "\nSelected: " 
		if main.item_exists_at(player.selected_cell):
			text += str(main.map_state[player.selected_cell].name) + " "
		text += str(player.selected_cell)
	else:
		text += "\nNo cell selected"
	text += "\nHolding: " + player.held_item.get_name_and_contents() if player.held_item else "\nNo held item"
