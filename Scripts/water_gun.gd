extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var popup_menu: Node2D = $"../../../Popup menu"

func _process(delta: float) -> void:
	if popup_menu.visible == false:
		gun(self, animation_player, "Pew")
