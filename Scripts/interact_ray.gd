extends RayCast3D

@onready var prompt: Label = $Prompt

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable:
			prompt.text = collider.get_prompt()
			
			if Input.is_action_just_pressed(collider.prompt_input):
				collider.interact(owner)
		else:
			prompt.text = ""
	else:
		prompt.text = ""
