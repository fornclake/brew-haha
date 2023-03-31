extends CanvasLayer

@export var player : Player

var text := "":
	set(value):
		label.text = value
		text = value

@onready var label = $Label


func _process(_delta):
	text = ""
	
	text += "Player grid position: " + str(player.grid_position)
	text += "\nPlayer direction: " + str(player.orth_direction)
	text += "\nSelected tile: " + str(player.grid_position + player.orth_direction)
