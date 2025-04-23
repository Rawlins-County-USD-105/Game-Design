extends TextureButton
class_name SkillNode

@export_multiline var text: String

@onready var panel: Panel = $Panel
@onready var label: Label = $MarginContainer/Label
@onready var line_2d: Line2D = $Line2D
@onready var label_2: Label = $PanelContainer/MarginContainer/Label2
@onready var panel_container: PanelContainer = $PanelContainer

func _ready():
	if get_parent() is SkillNode:
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(get_parent().global_position + size/2)
	label_2.text = text


var level : int = 0:
	set(value):
		level = value
		label.text = str(level) + "/3"

func _on_pressed() -> void:
	level = min( level+1 , 3)
	panel.show_behind_parent = true
	
	
	line_2d.default_color = Color(0.318, 0.141, 0.847)
	var skills = get_children()
	for skill in skills:
		if skill is SkillNode and level == 3:
			skill.disabled = false



func _on_label_2_mouse_entered() -> void:
	panel_container.visible = true



func _on_label_2_mouse_exited() -> void:
	panel_container.visible = false
