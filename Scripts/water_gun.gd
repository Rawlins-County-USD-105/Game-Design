extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var skill_tree: Control = $"../../../SkillTree"
@onready var skill_tree_2: Control = $"../../../SkillTree2"



func _process(delta: float) -> void:
	if skill_tree.visible == false and skill_tree_2.visible == false:
		gun(self, animation_player, "Pew")
