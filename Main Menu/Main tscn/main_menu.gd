extends Control
@onready var settings: Button = $MarginContainer/HBoxContainer/VBoxContainer/Settings
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $AnimationPlayer/Timer
@onready var input_settings: Control = $InputSettings





## buttons link to different scenes.

## 1 is the setting menu for keybind changing

## 2 Singleplayer starts the game for single

func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Models/game.tscn")
	
	
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Models/game.tscn")
	
	



func _on_button_4_pressed() -> void:
	input_settings.visible = true


func _process(float):
	
	if input_settings.visible == true and Input.is_action_just_pressed("Settings Close"):
		input_settings.visible = false

	
