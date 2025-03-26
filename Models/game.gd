extends Node3D

@onready var spawn_zones = {$SpawnZones/spawn1:1, $SpawnZones/spawn2:2}

func _process(delta: float) -> void:
	pass
			
func spawning():
	for x in spawn_zones:
		var rand = randi_range(1,2)
		if x:
			pass
