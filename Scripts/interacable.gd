extends CollisionObject3D
class_name Interactable

@export var prompt = "Interact"
@export var prompt_input = "Interact"

func get_prompt():
	var key_name = ""
	for action in InputMap.action_get_events(prompt_input):
		if action is InputEventKey:
			key_name = action.as_text_physical_keycode()
			break
	
	return prompt + "\n[" + key_name + "]"
	
func interact(body):
	print(body.name + " interacted with " + name)
