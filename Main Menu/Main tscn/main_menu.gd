extends Control
@onready var settings: Button = $MarginContainer/HBoxContainer/VBoxContainer/Settings
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $AnimationPlayer/Timer





## buttons link to different scenes.

## 1 is the setting menu for keybind changing

## 2 Singleplayer starts the game for single

func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Map.tscn")
	
	
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Map.tscn")
	
	



func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menu/Input Map Page/Input_Settings.tscn")
	
