extends CollisionShape3D

@export var damage := 1
var health = 6
signal collisionshape3d_hit(dam)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func hit():
	emit_signal("collisionshape3d_hit", damage)
	
func _on_collisionshape3d_hit(dam):
	health -= dam
	if health <= 0:
		queue_free()
