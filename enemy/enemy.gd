extends CharacterBody3D

class_name Enemy


var player= null
@export var Damage = 1.0
@export var player_path : NodePath
@export var mesh : MeshInstance3D
@export var hitbox : CollisionShape3D
@export var nav_agent : NavigationAgent3D
@export var animation : AnimationPlayer
@export var speed : int
var Health = 20.0
signal hit(Damage)
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	velocity = Vector3.ZERO
	 
	# Navigation
	nav_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	move_and_slide()
	
func Hit():
	Health -= Damage
	if Health <= 0:
		queue_free()

func _on_character_body_3d_hit(Damage: Variant) -> void:
	emit_signal("hit")


func _on_bullet_visibility_changed() -> void:
	pass # Replace with function body.
