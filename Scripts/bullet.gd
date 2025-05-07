extends Node3D

class_name bullet

@export var Damage: int
@export var speed: int = 10
@export var mesh: MeshInstance3D
@export var ray: RayCast3D
@export var particles: GPUParticles3D

var target: Vector3
var has_target := false

func _ready():
	has_target = target != Vector3.ZERO

func _process(delta):
	if has_target:
		var move_step = (target - global_transform.origin).normalized() * speed * delta
		position += move_step

		# Trigger when close enough to the point
		if global_transform.origin.distance_to(target) < 0.1:
			if ray.enabled and ray.get_collider():
				_hit_with_ray()
			_hit_target()
	else:
		position += transform.basis * Vector3(0, 0, -speed) * delta
	
	if ray.enabled and ray.get_collider():
		_hit_with_ray()

func _hit_target():

	mesh.visible = false
	particles.emitting = true
	ray.enabled = false
	await get_tree().create_timer(0.1).timeout
	queue_free()

func _hit_with_ray():
	var collider = ray.get_collider()
	if collider and collider.is_in_group("Enemy"):
		collider.Hit(Damage)

	mesh.visible = false
	particles.emitting = true
	ray.enabled = false
	await get_tree().create_timer(0.1).timeout
	queue_free()
