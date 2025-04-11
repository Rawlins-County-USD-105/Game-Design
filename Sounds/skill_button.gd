extends TextureButton
class_name SkillNode

var barrel = 1
@onready var panel: Panel = $Panel
@onready var label: Label = $MarginContainer/Label
@onready var line_2d: Line2D = $Line2D
var button = preload("res://Scenes/oil_button.gd")
var oil = Oil.barrel
func _ready():
	if get_parent() is SkillNode:
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(get_parent().global_position + size/2)

func _process(delta: float) -> void:
	print(oil)
	
	




var level : int = 0:
	set(value):
		level = value
		label.text = str(level) + "/3"

func _on_pressed() -> void:
	
	if barrel > 0:
		level = min( level+1 , 3)
		barrel -= 1
		panel.show_behind_parent = true
	
	
	
	line_2d.default_color = Color(0.318, 0.141, 0.847)
	var skills = get_children()
	for skill in skills:
		if skill is SkillNode and level == 3:
			skill.disabled = false

	

	
