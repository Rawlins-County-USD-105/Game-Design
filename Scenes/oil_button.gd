extends Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player_drill: AnimationPlayer = $"../AnimationPlayer"

func _on_interacted(body: Variant) -> void:
	body.spawning = true
	animation_player.play("press")
	animation_player_drill.play("drill")
