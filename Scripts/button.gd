extends Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer

#this will play will the button is interacted with
func _on_interacted(body: Variant) -> void:
	animation_player.play("press")
