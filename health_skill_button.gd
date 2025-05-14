extends TextureButton

@onready var barrels = 0
@onready var panel: Panel = $Panel
#@onready var label: Label = $MarginContainer/Label
@onready var line_2d: Line2D = $Line2D
@onready var label: Label = $Label
var level = 0

func _ready():
	if get_parent() is SkillNode:
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(get_parent().global_position + size/2)

func _on_pressed() -> void:
	if Game.barrels > 0:
		level += 1
		label.text = str(level)
		Game.barrels -= 1
		panel.show_behind_parent = true
		line_2d.default_color = Color(0.318, 0.141, 0.847)
		Gain.max_player_health =  Gain.max_player_health * 1.12
