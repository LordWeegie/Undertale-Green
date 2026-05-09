extends Node

const item_slot = preload("res://scene/ui/test.tscn")

var row_size = 1
var col_size = 8
var items = []

func _ready() -> void:
	for x in range(row_size):
		items.append([])
		
		for y in range(col_size):
			items[x].append([])
			
			var instance = item_slot.instantiate()
			instance.global_position = Vector2(x*50, y*50)
			instance.slot_num = Vector2i(x,y)
			add_child(instance)
			items[x][y] = instance
