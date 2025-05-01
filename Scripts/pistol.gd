extends Weapon

@onready var pistol_anim: AnimationPlayer = $pistol_anim


@onready var popup_menu: Node2D = $"../../../Popup menu"
@onready var skill_tree: Control = $"../../../SkillTree"
@onready var weapon_skill_tree: Control = $"../../../WeaponSkillTree"



func _process(delta: float) -> void:
	if skill_tree.visible == false and popup_menu.visible == false and weapon_skill_tree.visible == false:
		gun(self, pistol_anim, "fire")
