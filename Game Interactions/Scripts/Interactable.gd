extends CollisionObject3D
class_name Interactable

@export var prompt_message = "Interact"

func Interact(body):
	print(body.name, " interacted with ", name)
