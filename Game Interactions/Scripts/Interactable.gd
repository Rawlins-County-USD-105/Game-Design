extends CollisionObject3D
class_name Interactable

@export var prompt_message = "Interact"
@export var prompt_input = "interact" 



func get_prompt():
	var key_name = ""
func Interact(body):
	print(body.name, " interacted with ", name)
