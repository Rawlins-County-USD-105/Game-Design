extends Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player_drill: AnimationPlayer = $"../AnimationPlayer"
@onready var oil_bar: ProgressBar = $"../OilBar"
@onready var timer: Timer = $"../Timer"
@onready var barrels: Label = $"../Barrels"
@onready var gpu_particles_3d: GPUParticles3D = $"../GPUParticles3D"
@onready var begin_drill: AudioStreamPlayer3D = $"../begin_drill"
@onready var animation_player_down: AnimationPlayer = $"../AnimationPlayer/AnimationPlayer"

var round = 0
var oil = 0
var max_oil = 500
var player = null

func _ready() -> void:
	oil_bar.hide()
	oil_bar.max_value = max_oil
	oil_bar.value = 0
	oil = 0
	round = 0
	

func _process(delta: float) -> void:
	barrels.text = str(Game.barrels)
	Game.oil(round)
func _on_interacted(body: Variant) -> void:

	begin_drill.play()
	oil_bar.show()
	player = body
	player.spawning = true
	animation_player.play("press")
	animation_player_drill.play("drill")
	animation_player_down.play("Down")
	timer.start()

func get_oil():
	var label_text = str(oil_bar.value / oil_bar.max_value * 100)
	
	oil_bar.value = oil
	
	if oil_bar.value == oil_bar.max_value:
		begin_drill.stop()
		Game.barrels += 1
		round += 1
		player.spawning = false
		await get_tree().create_timer(.01).timeout
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
		animation_player_down.stop()
		animation_player_down.play("RESET")
		gpu_particles_3d.emitting = false
