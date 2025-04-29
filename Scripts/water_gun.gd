extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(delta: float) -> void:
		gun(self, animation_player, "Pew")
