class_name Player extends CharacterBody2D

const SPEED = 120
const COLLISION_OFFSET = Vector2(16, 4)
const CELL_SIZE = Vector2(32,32)

var grid_position : Vector2: # current position rounded to a 32*32 grid
	get: return ((position + COLLISION_OFFSET) / CELL_SIZE).round() - Vector2(1,0)
var input_direction : Vector2: # vector of currently pressed arrow keys
	get: return Input.get_vector("move_left", "move_right", "move_up", "move_down")
var orth_direction : Vector2: # last orthogonal vector player has faced
	get:
		if input_direction in [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]:
			orth_direction = input_direction
		return orth_direction
var selected_cell : Vector2: # cell player is facing
	get: return grid_position + orth_direction

var main : Main # set by Main on all nodes in Player group
@onready var selector = $Selector


func _physics_process(_delta):
	velocity = input_direction * SPEED
	move_and_slide()
	
	# show selector sprite only if player is facing a counter
	if main.cell_is_valid(selected_cell):
		selector.show()
		selector.position = selected_cell * CELL_SIZE
	else:
		selector.hide()
