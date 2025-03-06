extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Input.is_action_just_pressed("Open popup"):
		animation_player.play("Open popup")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menu/Main tscn/main_menu.tscn")
	
	
	
	



func _on_window_close_requested() -> void:
	animation_player.play("Close")
