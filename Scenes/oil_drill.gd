extends Node3D
@onready var hitbox: CollisionShape3D = $Container/RigidBody/Hitbox

var drill_health = 8000
var max_drill_health = 8000
@onready var healthbar: ProgressBar = $SubViewport/Healthbar
@onready var damagebar: ProgressBar = $SubViewport/Healthbar/Damagebar
@onready var damage_bar_timer: Timer = $SubViewport/Healthbar/DamageBarTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	healthbar.max_value = max_drill_health
	healthbar.value = drill_health
	damagebar.max_value = max_drill_health
	damagebar.value = drill_health
	
func took_damage(Damage):
	
	if Damage > drill_health:
		drill_health = 0
	else:
		damage_bar_timer.start()
		drill_health -= Damage
		
	if drill_health <= 0:
		damagebar.value = 0
		print("Drill Broke")

	
	healthbar.value = drill_health

func _process(delta: float) -> void:
	pass
