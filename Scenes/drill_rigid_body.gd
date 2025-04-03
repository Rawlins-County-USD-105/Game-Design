extends RigidBody3D

@onready var oil_drill: Node3D = $"../.."

func took_damage(Damage):
	oil_drill.took_damage(Damage)
