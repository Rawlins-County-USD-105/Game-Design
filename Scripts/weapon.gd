extends Node3D

class_name Weapon

@onready var watergun: Weapon = $"."
@onready var gun_sound: AudioStreamPlayer3D = $"gun sound"


@export var weapon_anim: AnimationPlayer
@export var model: MeshInstance3D
@export var barrel: RayCast3D
@export var gun_bullet: PackedScene
var instance
var Water_Cost = 10
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if watergun.visible == true:
		if Input.is_action_pressed("Pew") and not weapon_anim.is_playing():
<<<<<<< HEAD
			
			if Water_Cost > Gain.Water:
				pass
			else:
				Gain.Use_Water(Water_Cost)
				weapon_anim.play("Pew")
				instance = gun_bullet.instantiate()
				instance.position = barrel.global_position
				instance.transform.basis = barrel.global_transform.basis
				get_parent().add_child(instance)
=======
			weapon_anim.play("Pew")
			gun_sound.play()
			instance = gun_bullet.instantiate()
			instance.position = barrel.global_position
			instance.transform.basis = barrel.global_transform.basis
			get_parent().add_child(instance)
>>>>>>> main
	else:
		pass
