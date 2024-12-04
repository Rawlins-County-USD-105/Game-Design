extends Node3D

class_name bullet


@export var speed: int
@export var mesh: MeshInstance3D
@export var ray: RayCast3D
@export var particles: GPUParticles3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0, 0, -speed) * delta
	if ray.is_colliding():
		mesh.visible = true
		particles.emitting = true
		await get_tree().create_timer(1.0).timeout
		queue_free()
