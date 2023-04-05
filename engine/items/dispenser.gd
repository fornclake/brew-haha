class_name Dispenser extends Item

@export var output : Ingredient

@export var requires_ingredient : Array[Ingredient]

var _requires_ingredient_names : Array[String]:
	get:
		var array : Array[String] = []
		for ingredient in requires_ingredient:
			array.append(ingredient.name)
		return array


func can_dispense_to(ingredient : Ingredient):
	return true if _requires_ingredient_names.has(ingredient.name) else false
