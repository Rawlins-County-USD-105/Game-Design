extends Node3D
@onready var spawn_1: Area3D = $SpawnZones/spawn1
@onready var spawner: Node3D = $Spawner
@onready var enemy = preload("res://enemy/chicken.tscn")
@onready var spawn_zones = {$SpawnZones/spawn1:1, $SpawnZones/spawn2:2}
@onready var group_enemy = $Enemies
@onready var spawn_zones_node: Node3D = $SpawnZones

var total_enemies = 0
var enemies_spawned = 0
func _process(delta: float) -> void:
	spawning()
			
func spawning():
	for x in spawn_zones:
		var rand = randi_range(1,2)
		if x:
			
			if spawning:
				if Game.enemies_spawned < 5 && Game.total_enemies < 30000:
					Game.enemies_spawned += 1
					Game.total_enemies += 1
					var e_inst = enemy.instantiate()
					e_inst.player = $NavigationRegion3D/player
					e_inst.position = x.global_position
					group_enemy.add_child(e_inst)
				else:
					pass
