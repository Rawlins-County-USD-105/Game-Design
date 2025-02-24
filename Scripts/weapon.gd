extends Node3D

class_name Weapon

@export var model: MeshInstance3D
@export var barrel: RayCast3D
@export var gun_bullet: PackedScene
var instance

func gun(current_gun, animation_player, animation_name):
	if current_gun.visible == true:
		if Input.is_action_pressed(animation_name) and not animation_player.is_playing():
			
			Gain.Use_Water(10)
			
			animation_player.play(animation_name)
			instance = gun_bullet.instantiate()
			instance.position = barrel.global_position
			instance.transform.basis = barrel.global_transform.basis
			get_parent().add_child(instance)
	else:
		pass
