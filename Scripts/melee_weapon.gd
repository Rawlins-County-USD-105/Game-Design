extends Node3D

class_name melee
@onready var root_scene: melee = $"."

@export var Damage = 50.0
@export var speed: int
@export var weapon_anim: AnimationPlayer
@export var model: MeshInstance3D
@onready var ray: RayCast3D = $RayCast3D
@onready var shovel_swoosh: AudioStreamPlayer3D = $shovel_swoosh
@onready var shovel_slice: AudioStreamPlayer3D = $shovel_swoosh/shovel_slice





var instance

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var skill_tree_2: Control = $"../../../SkillTree2"
@onready var popup_menu: Node2D = $"../../../Popup menu"
@onready var skill_tree: Control = $"../../../SkillTree"

func _process(delta: float) -> void:
	if popup_menu.visible == false and skill_tree.visible == false and skill_tree_2.visible == false:
		if Input.is_action_pressed("Pew") and not weapon_anim.is_playing() and root_scene.visible == true:
			weapon_anim.play("Melee")
			shovel_swoosh.play()
		if ray.get_collider():
			if ray.get_collider().is_in_group("Enemy"):
				ray.get_collider().Hit(Damage)
				shovel_slice.play()
