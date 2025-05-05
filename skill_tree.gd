extends Control

@onready var skill_tree: Control = $"."




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#skill_tree2.visible = false
	skill_tree.visible =false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(skill_tree.visible)
	if skill_tree.visible == false and Input.is_action_just_pressed("Skill Tree"):
	#	skill_tree2.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#elif skill_tree2.visible == true and Input.is_action_just_pressed("Skill Tree"):
		
	#	skill_tree2.visible = false
		skill_tree.visible = true
	elif skill_tree.visible == true and Input.is_action_just_pressed("Skill Tree"):
		skill_tree.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
