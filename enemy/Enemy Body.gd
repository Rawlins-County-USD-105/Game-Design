extends RigidBody3D


var Damage
signal Body_hit(Damage)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func hit():
	emit_signal("Body_hit" , Damage)
	
