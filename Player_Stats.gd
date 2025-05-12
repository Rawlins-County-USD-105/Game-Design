extends Node


signal stats_updated

enum upgrades {ADD_HEALTH, ADD_SPEED, COLLECTOR_SPEED}
@onready var collector_speed: Timer = $"../Timer"
var addhealth = 0
var addspeed = 0
var addcollector_speed = 0
func add_upgrade(upgrade, stat):
	pass
	
func reset_upgrade():
	addhealth = 0
	addspeed = 0
	addcollector_speed = 0
	
func get_upgraded_health():
	return health + addhealth
	
func get_upgraded_speed():
	return SPEED + addspeed
	
func get_upgraded_collector_speed():
	return collector_speed - addcollector_speed / 10.0
	


func _on_stats_updated() -> void:
	pass # Replace with function body.
