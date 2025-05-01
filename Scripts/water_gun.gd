extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var skill_tree: Control = $"../../../SkillTree"
@onready var skill_tree_2: Control = $"../../../SkillTree2"
@onready var popup_menu: Node2D = $"../../../Popup menu"



func _process(delta: float) -> void:
	if skill_tree.visible == false and skill_tree_2.visible == false and popup_menu.visible == false:
		gun(self, animation_player, "Pew")
