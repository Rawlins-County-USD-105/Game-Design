extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var window: = $"."


var windowv = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if window.visible == false and Input.is_action_just_pressed("Open popup"):
		window.visible = true
		
	elif window.visible == true and Input.is_action_just_pressed("Open popup"):
		window.visible = false
	

		print(window.visible)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menu/Main tscn/main_menu.tscn")
	
	
	
	
