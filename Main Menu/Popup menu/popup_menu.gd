extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer



@onready var window: Node2D = $"."

@onready var buttonclose: Button = $Sprite2D/buttonclose
@onready var input_settings: Control = $InputSettings
@onready var skill_tree: Control = $SkillTree


var windowv = false
var Level = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if skill_tree.visible == true:
		window.visible = false
		Level = 0


	if window.visible == false and Level == 0 and Input.is_action_just_pressed("Open popup") and not skill_tree.visible == true:
		window.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Level = 1
		animation_player.play("ESCAPECLOSE")
		print("Popup.visible")
		
	elif window.visible == true and Level == 1 and Input.is_action_just_pressed("Open popup"):
		window.visible = false
		Level = 0
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		print("Popup.disapear")
	
	if input_settings.visible == true and Level == 2 and Input.is_action_just_pressed("Open popup"):
		input_settings.visible = false
		Level = 1

		print("Input.settings.disapear")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menu/Main tscn/main_menu.tscn")
	
	
func _on_buttonclose_pressed() ->void:
	window.visible = false





func _on_button_2_pressed() -> void:
	input_settings.visible = true
	
	Level = 2
	print("Input.settings.visible")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menu/Main tscn/main_menu.tscn")
