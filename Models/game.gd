extends Node3D
@onready var spawn_1: Area3D = $SpawnZones/spawn1
@onready var spawner: Node3D = $Spawner
@onready var enemy = preload("res://enemy/chicken.tscn")
@onready var enemy2 = preload("res://enemy/Bicken.tscn")
@onready var enemies = {enemy:1, enemy2:2}
@onready var spawn_zones = {$SpawnZones/spawn1:1, $SpawnZones/spawn2:2, $SpawnZones/spawn3:3, $SpawnZones/spawn4:4}
@onready var group_enemy = $Enemies
@onready var spawn_zones_node: Node3D = $SpawnZones
@onready var spawn_timer: Timer = $Spawner/SpawnTimer
@onready var oil_drill: Node3D = $NavigationRegion3D/NavigationRegion3D/Oil_Drill
@onready var player: CharacterBody3D = $player
@onready var spawn_point: Marker3D = $"Spawner/Spawn Point"
@onready var world_environment: WorldEnvironment = $WorldEnvironment

var spawn_enemy = null
var can_spawn = false
var total_enemies = 0
var enemies_spawned = 0
var fog = false
var fog_density = 0

func _ready() -> void:
	
	if player:
		
		player.drill_hitbox = oil_drill.hitbox

func _process(delta: float) -> void:
	
	print(fog)
	if player:
		if player.spawning:
			if spawn_timer:
				if Game.enemies_spawned < 5 && spawn_timer.is_stopped():
					spawning()
		else:
			pass
	
	if fog:
		fog_density += 0.025 * delta
		
		world_environment.environment.volumetric_fog_density = fog_density
		
		if world_environment.environment.volumetric_fog_density > 0.3:
			fog = false


func spawning():
	var random_number = randi_range(1,360)
	var rand = randi_range(1,4)
	for x in spawn_zones:
		if x && rand == spawn_zones.get(x):
			spawn_timer.start()
			
			if spawning:
				var rand_ene = randi_range(1,10)
				if rand_ene == 10:
					spawn_enemy = enemies.find_key(2)
					fog = true
					$Horror.play()
				else:
					spawn_enemy = enemies.find_key(1)
				if Game.enemies_spawned < 5 && Game.total_enemies < 30000:
					Game.enemies_spawned += 1
					Game.total_enemies += 1
					spawner.position = x.global_position
					spawner.rotate_y(deg_to_rad(random_number))
					var e_inst = spawn_enemy.instantiate()
					e_inst.player = $player
					e_inst.drill = oil_drill.hitbox
					e_inst.position = spawn_point.global_position
					group_enemy.add_child(e_inst)
					
				else:
					pass
