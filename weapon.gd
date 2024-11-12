extends Node3D

class_name Weapon

@export var damage: int
@export var speed: int
@export var firerate: Timer
@export var weapon_anim: AnimationPlayer
@export var model: MeshInstance3D
@export var raycast: RayCast3D
@export var bullet: PackedScene


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	#if Input.is_action_pressed("Pew") and Timercooldown.is_stopped():
			#gun_anim.play("Pew")
			#instance = bullet.instantiate()
			#instance.position = gun_barrel.global_position
			#instance.transform.basis = gun_barrel.global_transform.basis
			#get_parent().add_child(instance)
			#Timercooldown.start()
