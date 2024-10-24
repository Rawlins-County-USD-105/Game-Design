extends Control
@onready var settings: Button = $MarginContainer/HBoxContainer/VBoxContainer/Settings






func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menu/Input Map Page/Input_Settings.tscn")
