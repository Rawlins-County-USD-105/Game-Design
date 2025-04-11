extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var popup_menu: Node2D = $"../../../Popup menu"
@onready var skill_tree: Control = $"../../../SkillTree"

func _process(delta: float) -> void:
	if popup_menu.visible == false and skill_tree.visible == false:
		gun(self, animation_player, "Pew")
