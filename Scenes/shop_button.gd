extends "res://Scripts/interacable.gd"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var skill_tree: Control = $SkillTree


func _on_interacted(body: Variant) -> void:
	animation_player.play("press")
	skill_tree.visible = true
