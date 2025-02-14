extends Control
@onready var settings: Button = $MarginContainer/HBoxContainer/VBoxContainer/Settings
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $AnimationPlayer/Timer

@onready var timer2: Timer = $Timer2



## buttons link to different scenes.

## 1 is the setting menu for keybind changing

## 2 Singleplayer starts the game for single

func _on_button_3_pressed() -> void:
	animation_player.play("Single Player Mode")
	timer.start()
	
	
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Models/game.tscn")
	
	



func _on_button_4_pressed() -> void:
	animation_player.play("Single Player Mode")
	timer2.start()
	

	


func _on_timer2_timeout() -> void:
	get_tree().change_scene_to_file("res://Main Menu/Input Map Page/Input_Settings.tscn")
