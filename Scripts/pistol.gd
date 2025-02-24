extends Weapon

@onready var pistol_anim: AnimationPlayer = $pistol_anim

func _process(delta: float) -> void:
	gun(self, pistol_anim, "fire")
