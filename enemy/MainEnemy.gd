extends Node3D


@export var Health: int 
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_rigid_body_3d_body_hit(Damage: Variant) -> void:
	Health -= Damage
	if Health <= 0:
		queue_free()
