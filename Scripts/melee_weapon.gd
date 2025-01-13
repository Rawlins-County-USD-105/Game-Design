extends Node3D

class_name melee

@export var Damage = 10000000000.0
@export var speed: int
@export var weapon_anim: AnimationPlayer
@export var model: MeshInstance3D
@export var ray: RayCast3D

var instance

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta: float) -> void:
	if Input.is_action_pressed("Pew") and not weapon_anim.is_playing():
		weapon_anim.play("Melee")
