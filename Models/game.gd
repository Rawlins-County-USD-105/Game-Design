extends Node3D

var total_enemies = 0
var enemies_spawned = 0
@onready var player: CharacterBody3D = $NavigationRegion3D/player
@onready var oil_drill: Node3D = $NavigationRegion3D/Oil_Drill

func _ready() -> void:
	if player:
		
		player.drill_hitbox = oil_drill.hitbox
	
