extends TextureRect

@export_multiline var text: String
@onready var label_2: Label = $PanelContainer/MarginContainer2/Label2
@onready var texture_rect: TextureRect = $"."
@onready var panel_container: PanelContainer = $PanelContainer


func _ready() -> void:
	panel_container.visible = false
func _on_mouse_entered() -> void:
	panel_container.visible = true
func _on_mouse_exited() -> void:
	panel_container.visible = false
