extends Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var skill_tree: Control = $SkillTree

var Water = 100
#this will play will the button is interacted with
func _on_interacted(body: Variant) -> void:
	if Gain.Gold >= 50:
		Gain.Gain_Water(Water)
		Gain.Gain_Gold(Water * -1)
