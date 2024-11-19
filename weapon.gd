extends Node3D

class_name Weapon

@export var damage: int
@export var speed: int
@export var weapon_anim: AnimationPlayer
@export var model: MeshInstance3D
@export var barrel: RayCast3D
@export var gun_bullet: PackedScene
@export var raycast: RayCast3D
@export var bullet2: PackedScene


var instance

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(delta: float) -> void:
	
	if Input.is_action_pressed("Pew") and not weapon_anim.is_playing():
		print("works")
		weapon_anim.play("Pew")
		instance = gun_bullet.instantiate()
		instance.position = barrel.global_position
		instance.transform.basis = barrel.global_transform.basis
		get_parent().add_child(instance)


#Shooting

	if Input.is_action_pressed("Shoot") and firerate.is_stopped():
			weapon_anim.play("Pew")
			instance = bullet2.instantiate()
			instance.position = model.global_position
			instance.transform.basis = model.global_transform.basis
			get_parent().add_child(instance)
			firerate.start()
