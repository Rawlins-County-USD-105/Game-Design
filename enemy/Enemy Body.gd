extends RigidBody3D


@export var damage: int
signal Body_hit(damage)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func hit():
	emit_signal("Body_hit" , damage)
	
