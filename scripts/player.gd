class_name Player extends CharacterBody2D

const SPEED = 120

var grid_position : Vector2i: # current position rounded to a 32*32 grid
	get: return ((position + Vector2(12, 4)) / Vector2(32, 32)).round()

var input_vector : Vector2: # vector of currently pressed arrow keys
	get: return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

var orth_direction : Vector2i: # last orthogonal vector player has faced
	get:
		if input_vector in [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]:
			orth_direction = input_vector
		return orth_direction


func _physics_process(_delta):
	velocity = input_vector * SPEED
	move_and_slide()
