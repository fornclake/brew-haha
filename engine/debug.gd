extends CanvasLayer

@export var player : Player
@export var main : Main

var text := "":
	set(value):
		label.text = value
		text = value

@onready var label = $Label

var DIRECTIONS = {Vector2.LEFT: "Left", Vector2.RIGHT: "Right", Vector2.UP: "Up", Vector2.DOWN: "Down"}


func _process(_delta):
	text = ""
	
	text += "Position: " + str(player.grid_position)
	text += "\nDirection: " + DIRECTIONS[player.orth_direction]
	text += "\nSelected: " + str(player.selected_cell) if player.can_interact else "\nNo tile selected"
	text += "\nHolding " + str(player.held_item.name) if player.held_item else "\nNo held item"
	text += "\nHeld item contents: " \
			+ str(player.held_item._content_names).replace("\"", "") if player.held_item else ""
