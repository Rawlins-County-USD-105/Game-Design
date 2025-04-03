extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var window: = $"."
@onready var buttonclose: Button = $Sprite2D/buttonclose
@onready var input_settings: Control = $InputSettings

var windowv = false
var Level = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(Level)

		
	if window.visible == false and Level == 1 and Input.is_action_just_pressed("Open popup"):
		window.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Level = 2
		animation_player.play("ESCAPECLOSE")
		
	elif window.visible == true and Level == 2 and Input.is_action_just_pressed("Open popup"):
		window.visible = false
		Level = 1
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if input_settings.visible == true and Level == 3 and Input.is_action_just_pressed("Open popup"):
		input_settings.visible = false
		Level = 2

		print(window.visible)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menu/Main tscn/main_menu.tscn")
	
	
func _on_buttonclose_pressed() ->void:
	window.visible = false





func _on_button_2_pressed() -> void:
	input_settings.visible = true
	Level = 3
	print("visible")


func _on_button_3_pressed() -> void:
	get_tree().quit()
