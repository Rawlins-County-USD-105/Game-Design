extends Node3D
@onready var spawn_1: Area3D = $SpawnZones/spawn1

@onready var spawn_zones = {$SpawnZones/spawn1:1, $SpawnZones/spawn2:2}
var total_enemies = 0
var enemies_spawned = 0
func _process(delta: float) -> void:
	spawning()
			
func spawning():
	for x in spawn_zones:
		var rand = randi_range(1,2)
		if x:
			print(x.position)
