extends Node3D

class_name melee
@onready var root_scene: melee = $"."

@export var Damage = 50.0
@export var speed: int
@export var weapon_anim: AnimationPlayer
@export var model: MeshInstance3D
@onready var ray: RayCast3D = $RayCast3D

var instance

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta: float) -> void:
	if Input.is_action_pressed("Pew") and not weapon_anim.is_playing() and root_scene.visible == true:
		weapon_anim.play("Melee")
		if ray.get_collider():
			if ray.get_collider().is_in_group("Enemy"):
				ray.get_collider().Hit(Damage)
