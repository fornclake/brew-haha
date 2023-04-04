class_name Ingredient extends Item

@export var allowed_ingredients : Array[Ingredient]:
	set(value):
		_allowed_ingredient_names = []
		for ingredient in value:
			_allowed_ingredient_names.append(ingredient.name)
		allowed_ingredients = value

var _allowed_ingredient_names : Array[String]
var _contents : Array[Ingredient] = []:
	set(value):
		_content_names = []
		for ingredient in value:
			_content_names.append(ingredient.name)
var _content_names : Array[String]

func can_hold(ingredient : Ingredient):
	return true if _allowed_ingredient_names.has(ingredient.name) else false

func has(ingredient : Ingredient):
	return true if _content_names.has(ingredient.name) else false

func add_ingredient(ingredient : Ingredient):
	_contents.append(ingredient)
