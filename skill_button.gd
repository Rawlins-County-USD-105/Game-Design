extends Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var skill_tree: Control = $SkillTree

#this will play will the button is interacted with
func _on_interacted(body: Variant) -> void:
	animation_player.play("press")
	if skill_tree.visible == false:
		skill_tree.visible = true
	else:
		skill_tree.visible = false
