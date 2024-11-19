extends Node3D

class_name melee

@export var damage: int
@export var speed: int
@export var weapon_anim: AnimationPlayer
@export var model: MeshInstance3D
@export var barrel: RayCast3D

var instance

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	
	if Input.is_action_pressed("Pew") and not weapon_anim.is_playing():
		print("works")
		weapon_anim.play("Pew")
		get_parent().add_child(instance)
