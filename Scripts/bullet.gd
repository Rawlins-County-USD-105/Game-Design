extends Node3D

class_name bullet

#var Watergun = get_tree().get_root().find_node("Watergun", true, false)
var target = null

@export var Damage = 5.0
@export var speed: int
@export var mesh: MeshInstance3D
@export var ray: RayCast3D
@export var particles: GPUParticles3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target != null:
		var direction = (target - global_transform.origin).normalized()
		
		position += direction * speed * delta
		
		if ray.get_collider():
			mesh.visible = false
			particles.emitting = true
			ray.enabled = false
			if ray.get_collider().is_in_group("Enemy"):
				ray.get_collider().Hit(Damage)
			await get_tree().create_timer(0).timeout
			queue_free()
	else:
		position += transform.basis * Vector3(0, 0, -speed) * delta
		
		if ray.get_collider():
			mesh.visible = false
			particles.emitting = true
			ray.enabled = false
			if ray.get_collider().is_in_group("Enemy"):
				ray.get_collider().Hit(Damage)
			await get_tree().create_timer(0).timeout
			queue_free()
		else:
			pass
