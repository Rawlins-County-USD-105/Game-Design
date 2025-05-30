extends Control


@onready var input_button_scene = preload("res://Main Menu/Input Map Page/Scenes/input_button.tscn")
@onready var action_list = $"PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/Action List"
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2
@onready var input_settings: Control = $"."

var is_remapping = false
var action_to_remap = null
var remapping_button = null

var input_actions = {
	"left": "Move Left",
	"right": "Move Right",
	"forward": "Move Forward",
	"back": "Move Backward",
	"sprint": "Sprint",
	"jump": "Jump",
	"Interact":"Interact",
	"crouch":"Crouch",
	"Pew":"Shoot",
	"Watergun":"Watergun",
	"Shovel":"Shovel",
	"Weapon3":"Pistol",
}

func _ready():
	_create_action_list()
	
	
	
func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
		
		
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
		
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))


func _on_input_button_pressed(button, action):
		if !is_remapping:
			is_remapping = true
			action_to_remap = action
			remapping_button = button
			button.find_child("LabelInput").text = "Press key to bind..."
			
			
			
func _input(event):
	if is_remapping:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			
			
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button,event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()
			
			
func _update_action_list(button, event):
	#make this scene do the change scene animations when you click the x on the screen.
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")
	
	



func _on_button_pressed() -> void:
	input_settings.visible = false
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Open popup"):
		visible = false
	
