extends Node3D

class_name Weapon



@export var model: MeshInstance3D
@export var barrel: RayCast3D
@export var gun_bullet: PackedScene
var instance
@export var water_cost : int
@onready var hit_scan_ray: RayCast3D = $"../HitScanRay"
@export var png : Texture2D
var target = null

func gun(current_gun, animation_player, animation_name):
	if hit_scan_ray.is_colliding():
		target = hit_scan_ray.get_collision_point()
	else:
		target = null
	if current_gun.visible == true:
		if Input.is_action_pressed("Pew") and not animation_player.is_playing() and Gain.Water >= water_cost:
			Gain.Use_Water(water_cost)
			animation_player.play(animation_name)
			instance = gun_bullet.instantiate()
			instance.position = barrel.global_position
			# Calculate the direction to the target
			if target:
				instance.target = target
				
				var direction = (target - barrel.global_position).normalized()
				# Create a basis where -Z points in the direction of travel
				var bullet_basis = Basis()
				bullet_basis = bullet_basis.looking_at(direction, Vector3.UP)
				# Apply it to the instance
				instance.transform.basis = bullet_basis
			else:
				instance.transform.basis = barrel.global_transform.basis
			
			get_parent().add_child(instance)
		if Input.is_action_just_pressed("inspect") and not animation_player.is_playing():
			animation_player.play("inspect")
	else:
		pass
