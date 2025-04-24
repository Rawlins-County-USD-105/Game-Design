extends TextureRect

@export_multiline var text: String
@onready var label_2: Label = $PanelContainer/MarginContainer2/Label2
@onready var texture_rect: TextureRect = $"."


func _ready():
	label_2.text = text


func _on_mouse_entered() -> void:
	texture_rect.visible = true

func _on_mouse_exited() -> void:
	texture_rect.visible = false
