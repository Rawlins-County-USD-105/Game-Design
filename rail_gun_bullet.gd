extends bullet

func _process(delta: float) -> void:
	Damage = Gain.rail_gun_damage
	shoot_bullet(delta)
