extends Node2D

const ITEM_SLOT = preload("res://Scenes/item_slot.tscn")

var row_size = 5
var col_size = 2
var iteams = []


func _ready() -> void:
	for x in range(row_size):
		iteams.append([])
		
		
		for y in range(col_size):
			iteams[x].append([])
			
			var instance = ITEM_SLOT.instantiate()
			instance.global_position = Vector2(x*50, y*50)
			instance.slot_num = Vector2i(x,y)
			add_child(instance)
			iteams[x][y] = instance
