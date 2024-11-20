extends Node3D
class_name Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var prompt_message = "Interact"
@export var prompt_input = "interact" 
@onready var collision_shape_3d: CollisionShape3D = $Door_1_grp/Door_1/CollisionShape3D
@onready var timer: Timer = $Timer



func get_prompt():
	var key_name = "Menu"
func Interact(body):
	print(body.name, " interacted with ", name)
	animation_player.play("Door Open")
	
