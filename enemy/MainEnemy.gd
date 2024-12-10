extends Node3D

var damage = 3.0
var Health = 120.0
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_rigid_body_3d_body_hit(damage: Variant) -> void: 
	damage = 3
	print(damage)
	Health -= damage
	if Health <= 0:
		queue_free()
