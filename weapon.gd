extends Node3D

class_name Weapon

@export var damage: int
@export var speed: int
@export var firerate: Timer
@export var weapon_anim: AnimationPlayer
@export var model: MeshInstance3D
@export var raycast: RayCast3D
@export var bullet: PackedScene

@onready var gun_anim = $neck/Camera/Node3D/AnimationPlayer
@onready var gun_barrel = $neck/Camera/Node3D/RayCast3D
@onready var Timercooldown = $"../Timer"

var instance
var bullet2 = load("res://bullet.tscn")

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


#Shooting

	if Input.is_action_pressed("Pew") and Timercooldown.is_stopped():
			print("works")
			gun_anim.play("Pew")
			instance = bullet2.instantiate()
			instance.position = gun_barrel.global_position
			instance.transform.basis = gun_barrel.global_transform.basis
			get_parent().add_child(instance)
			Timercooldown.start()
