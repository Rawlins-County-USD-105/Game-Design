extends Area3D

@export var Dam := 1

signal Area3D_hit(Dam)


func hit():
	emit_signal("Area3D_hit" , Dam)
	print("works")
