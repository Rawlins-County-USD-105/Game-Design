extends "res://Scripts/weapon.gd"

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

# Called when the node enters the scene tree for the first time.

func _process(delta: float) -> void:
	gun(self, animation_player, "Pew")
