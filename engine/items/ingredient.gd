class_name Ingredient extends Item

@export var allowed_ingredients : Array[Ingredient]
var _allowed_ingredient_names : Array[String]:
	get:
		var array : Array[String] = []
		for ingredient in allowed_ingredients:
			array.append(ingredient.name)
		return array


var contents : Array[Ingredient] = []

var _content_names : Array[String]:
	get:
		var array : Array[String] = []
		for ingredient in contents:
			array.append(ingredient.name)
		return array


func _ready():
	for ingredient in allowed_ingredients:
		_allowed_ingredient_names.append(ingredient.name)


func can_hold(ingredient : Ingredient):
	return true if _allowed_ingredient_names.has(ingredient.name) else false


func has(ingredient : Ingredient):
	return true if _content_names.has(ingredient.name) else false


func add_ingredient(ingredient : Ingredient):
	contents.append(ingredient)


func get_name_and_contents() -> String:
	return str(name, " ", _content_names).replace("\"", "")
