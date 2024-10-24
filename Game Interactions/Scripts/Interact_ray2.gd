extends RayCast3D

@onready var prompt: Label = $Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	if is_colliding():
		var collider = get_collider()
		
		print("Detecting Item...")
