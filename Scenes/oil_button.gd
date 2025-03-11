extends Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_interacted(body: Variant) -> void:
	body.spawning = true
	animation_player.play("press")
