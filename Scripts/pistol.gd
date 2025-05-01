extends Weapon

@onready var pistol_anim: AnimationPlayer = $pistol_anim


@onready var popup_menu: Node2D = $"../../../Popup menu"
@onready var skill_tree: Control = $"../../../SkillTree"
@onready var skill_tree_2: Control = $"../../../SkillTree2"

func _process(delta: float) -> void:
	if skill_tree.visible == false and skill_tree_2.visible == false and popup_menu.visible == false:
		gun(self, pistol_anim, "fire")
