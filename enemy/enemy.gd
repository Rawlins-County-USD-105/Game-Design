extends CharacterBody3D

class_name Enemy


var player= null


@export var player_path : NodePath
@export var mesh : MeshInstance3D
@export var hitbox : CollisionShape3D
@export var nav_agent : NavigationAgent3D
@export var animation : AnimationPlayer
@export var speed : int
var Health = 20


func _ready():
	player = get_node(player_path)



func _process(_delta):
	velocity = Vector3.ZERO
	 
	# Navigation
	nav_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	move_and_slide()





func _on_area_3d_area_3d_hit(Dam: Variant) -> void:
	print("hit")
	Health -= Dam
	if Health <= 0:
		queue_free()
