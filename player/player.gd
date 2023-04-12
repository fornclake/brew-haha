class_name Player extends CharacterBody2D

const SPEED = 120
const COLLISION_OFFSET = Vector2i(0, 16)
const CELL_SIZE = Vector2i(32,32)

var input_direction : Vector2: # vector of currently pressed arrow keys
	get: return Input.get_vector("move_left", "move_right", "move_up", "move_down")

var orth_direction := Vector2i.DOWN: # last orthogonal vector player has faced
	get:
		if input_direction in [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]:
			orth_direction = Vector2i(input_direction)
		return orth_direction

var grid_position : Vector2i: # current position rounded to a 32*32 grid
	get: return (Vector2i(0,16) + Vector2i(position)) / CELL_SIZE

var selected_cell : Vector2i: # cell player is facing
	get: return grid_position + orth_direction

var can_interact : bool: # player is facing an interactable cell
	get: return main.cell_is_valid(selected_cell)

var held_item : Ingredient = null
var main : Main # set by Main on all nodes in Player group

@onready var selector = $Selector

signal interacted(cell)


func _input(event):
	if can_interact and event.is_action_pressed("primary"):
		emit_signal("interacted", selected_cell)


func _physics_process(_delta):
	velocity = input_direction * SPEED
	
	move_and_slide()
	
	# show selector when facing an interactable tile
	selector.visible = can_interact
	selector.position = selected_cell * CELL_SIZE
