extends MeshInstance3D




# Called when the node enters the scene tree for the first time.
func Hit():
	emit_signal("hit")
	print("yay")
