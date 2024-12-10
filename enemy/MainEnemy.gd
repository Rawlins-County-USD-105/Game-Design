extends Node3D


var Health = 5
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_rigid_body_3d_body_hit(damage: Variant) -> void:
	Health -= damage
	if Health <= 0:
		queue_free()
