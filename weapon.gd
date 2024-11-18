extends Node3D

class_name Weapon

@export var damage: int
@export var speed: int
@export var firerate: Timer
@export var weapon_anim: AnimationPlayer
@export var model: MeshInstance3D
@export var raycast: RayCast3D
@export var bullet2: PackedScene


var instance

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


#Shooting

	if Input.is_action_pressed("Shoot") and Timer.is_stopped:
			weapon_anim.play("Pew")
			instance = bullet2.instantiate()
			instance.position = model.global_position
			instance.transform.basis = model.global_transform.basis
			get_parent().add_child(instance)
			Timer.start
