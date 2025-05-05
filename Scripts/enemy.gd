extends CharacterBody3D

class_name Enemy
var player = self
var drill = self
var target = player
#@export var player_path : NodePath
@export var Damage : int
@export var mesh : MeshInstance3D
@export var hitbox : CollisionShape3D
@export var nav_agent : NavigationAgent3D
@export var animation : AnimationPlayer

var Health : int
@onready var damage_ray: RayCast3D = $RayCast3D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var character_body_3d_2: CharacterBody3D = $"."
@onready var armature_006: Node3D = $Armature_006
@onready var explosion: GPUParticles3D = $GPUParticles3D


var passes = 0
var player_distance = 0
var drill_distance = 0
signal hit(Damage)
signal death
 #Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func move(_delta, speed, HP):

	passes += 1
	if passes < 2:
		Health = HP
	velocity = Vector3.ZERO
	if damage_ray.get_collider() == null:
		pass
	else:
		if damage_ray.is_colliding() and timer.is_stopped():
			if damage_ray.get_collider().is_in_group("Player") or damage_ray.get_collider().is_in_group("damageable"):
				damage_ray.get_collider().took_damage(Damage)
				timer.start()
		else:
			pass

	var player_distance = player.global_position.distance_to(self.global_position)
	var drill_distance = drill.global_position.distance_to(self.global_position)
	
	if drill_distance < 8:
		target = drill
	else:
		target = player
	
	var distance_to_player = global_position.distance_to(player.global_position)
	
	# Navigation
	nav_agent.set_target_position(target.global_transform.origin)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), _delta * 10)
	move_and_slide()
func Hit(Damage):
	Health -= Damage
	if Health <= 0:
		var Gold = 10
		Gain.Gain_Gold(Gold)
		Gain.Gain_Water(Gold)
		Game.enemies_spawned -= 1
		#Game.enemy_death()
		hitbox.disabled = true
		armature_006.visible = false
		explosion.emitting = true
		
		await get_tree().create_timer(.5).timeout
		queue_free()
		emit_signal("death")

func _on_character_body_3d_hit(Damage: Variant) -> void:
	emit_signal("hit")
	
