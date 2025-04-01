extends Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var skill_tree: Control = $SkillTree

func _on_button_interact(body: Variant) -> void:
	animation_player.play("push")
	if skill_tree.visible == true:
		skill_tree.visible = false
	else:
		skill_tree.visible = true
