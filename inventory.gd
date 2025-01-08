extends Node2D

const ITEAM_SLOT = preload("res://iteam_slot.gd")

var row_size = 5
var col_size = 2
var iteams = []


func _ready() -> void:
	for x in range(row_size):
		iteams.append([])
		
		
		for y in range(col_size):
			iteams[x].append([])
			
			var instance = ITEAM_SLOT.instantiate()
			instance.global_position = Vector2(x*50, y*50)
			instance.slot_num = Vector2i(x,y)
