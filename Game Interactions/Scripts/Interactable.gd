extends CollisionObject3D
class_name Interactable

@export var prompt_message = "Interact"
@export var prompt_input = "interact" 
@onready var collision_shape_3d: CollisionShape3D = $"../StaticBody3D/CollisionShape3D"



func get_prompt():
	var key_name = "Menu"
func Interact(body):
	print(body.name, " interacted with ", name)
	queue_free()
