extends Button

@onready var window: = $"."
func _on_buttonclose_pressed():
	window.visible = false
