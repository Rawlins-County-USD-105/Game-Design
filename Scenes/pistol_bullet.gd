extends bullet

func _process(delta: float) -> void:
	Damage = Gain.pistol_damage
	shoot_bullet(delta)
