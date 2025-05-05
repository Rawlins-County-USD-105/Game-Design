extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var skill_tree: Control = $"../../../SkillTree"
@onready var weapon_skill_tree: Control = $"../../../WeaponSkillTree"



@onready var popup_menu: Node2D = $"../../../Popup menu"


func _process(delta: float) -> void:
	if skill_tree.visible == false and popup_menu.visible == false and weapon_skill_tree.visible == false:
		gun(self, animation_player, "Pew")
