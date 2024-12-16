extends MeshInstance3D


var Damage = 3.0

signal Body_hit(Damage)
# Called when the node enters the scene tree for the first time.

func hit():
	emit_signal("Body_hit" , Damage)
	print(Damage)
