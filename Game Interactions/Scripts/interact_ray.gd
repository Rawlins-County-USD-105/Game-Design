extends RayCast3D

@onready var prompt: Label = $Label
@onready var animation_player: AnimationPlayer = $Label/AnimationPlayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	prompt.text = ""
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable:
			prompt.text = collider.prompt_message
			
			if Input.is_action_just_pressed("Interact"):
				collider.Interact(owner)
				animation_player.play("Click")
