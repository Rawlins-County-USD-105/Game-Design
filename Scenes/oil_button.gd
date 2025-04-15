extends Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player_drill: AnimationPlayer = $"../AnimationPlayer"
@onready var oil_bar: ProgressBar = $"../OilBar"
@onready var timer: Timer = $"../Timer"
@onready var barrels: Label = $"../Barrels"
@onready var gpu_particles_3d: GPUParticles3D = $"../GPUParticles3D"
@onready var health_bar_sprite: Node3D = $"../Health"
@onready var begin_drill: AudioStreamPlayer3D = $"../begin_drill"

var oil = 0
var max_oil = 100
var player = null
var barrel = 0

func _ready() -> void:
	oil_bar.hide()
	health_bar_sprite.hide()
	oil_bar.max_value = max_oil
	oil_bar.value = 0
	

func _process(delta: float) -> void:
	Game.pain(barrel)
	if player:
		health_bar_sprite.look_at(player.global_transform.origin, Vector3.UP)

func _on_interacted(body: Variant) -> void:
	begin_drill.play()
	oil_bar.show()
	health_bar_sprite.show()
	player = body
	player.spawning = true
	animation_player.play("press")
	animation_player_drill.play("drill")
	timer.start()

func get_oil():
	var label_text = str(oil_bar.value / oil_bar.max_value * 100)
	
	oil_bar.value = oil
	
	if oil_bar.value == oil_bar.max_value:
		begin_drill.stop()
		barrel += 1
		barrels.text = str(barrel)
		player.spawning = false
		await get_tree().create_timer(3).timeout
		oil = 0
		oil_bar.value = oil
		oil_bar.hide()


func _on_timer_timeout() -> void:
	if player.spawning:
		oil = oil + 1
		get_oil()
		timer.start()
	else:
		animation_player_drill.stop()
		gpu_particles_3d.emitting = false
