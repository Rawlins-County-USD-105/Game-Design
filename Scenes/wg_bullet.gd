extends bullet

func _process(delta: float) -> void:
	Damage = Gain.water_gun_damage
	shoot_bullet(delta)
