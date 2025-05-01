extends Control

@onready var weapon_skill_tree: Control = $"."



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon_skill_tree.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if weapon_skill_tree.visible == false and Input.is_action_just_pressed("WeaponSkills"):
		weapon_skill_tree.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif weapon_skill_tree.visible == true and Input.is_action_just_pressed("WeaponSkills"):
		weapon_skill_tree.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
