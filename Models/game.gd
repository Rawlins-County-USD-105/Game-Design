extends Node3D
@onready var spawn_1: Area3D = $SpawnZones/spawn1
@onready var spawner: Node3D = $Spawner
@onready var enemy = preload("res://enemy/chicken.tscn")
@onready var enemy2 = preload("res://enemy/Bicken.tscn")
@onready var enemies = {enemy:1, enemy2:2}
@onready var spawn_zones = {$SpawnZones/spawn1:1, $SpawnZones/spawn2:2}
@onready var group_enemy = $Enemies
@onready var spawn_zones_node: Node3D = $SpawnZones
@onready var spawn_timer: Timer = $Spawner/SpawnTimer
@onready var oil_drill: Node3D = $NavigationRegion3D/Oil_Drill
@onready var player: CharacterBody3D = $player

var can_spawn = false
var total_enemies = 0
var enemies_spawned = 0
func _process(delta: float) -> void:
	if player:
		if player.spawning:
			if spawn_timer:
				if Game.enemies_spawned < 5 && spawn_timer.is_stopped():
					spawning()
		else:
			pass


func spawning():
	for x in spawn_zones:
		var rand = randi_range(1,2)
		if x && rand == spawn_zones.get(x):
			spawn_timer.start()
			
			if spawning:
				if Game.enemies_spawned < 5 && Game.total_enemies < 30000:
					Game.enemies_spawned += 1
					Game.total_enemies += 1
					var e_inst = enemies.find_key(rand).instantiate()
					e_inst.player = $player
					e_inst.drill = oil_drill.hitbox
					e_inst.position = x.global_position
					group_enemy.add_child(e_inst)
				else:
					pass


func _ready() -> void:
	if player:
		
		player.drill_hitbox = oil_drill.hitbox
	
