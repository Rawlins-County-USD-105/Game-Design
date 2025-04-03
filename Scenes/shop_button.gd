extends Interactable


# Called when the node enters the scene tree for the first time.
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var skill_tree: Control = $SkillTree

# Called when the node enters the scene tree for the first time.
func _on_interacted(body: Variant) -> void:
	animation_player.play("press")
	if skill_tree.visible == false:
		skill_tree.visible = true
	else:
		skill_tree.visible = false
	
