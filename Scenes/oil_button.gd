extends Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player_drill: AnimationPlayer = $"../AnimationPlayer"
@onready var oil_bar: ProgressBar = $"../OilBar"
@onready var timer: Timer = $"../Timer"
@onready var barrels: Label = $"../Barrels"
@onready var gpu_particles_3d: GPUParticles3D = $"../GPUParticles3D"
@onready var begin_drill: AudioStreamPlayer3D = $"../begin_drill"
@onready var end_drill: AudioStreamPlayer3D = $"../end_drill"
@onready var health_bar_sprite: Node3D = $"../Health"

var oil = 0
var max_oil = 1000
var player = null
var barrel = 0
var sound_playing = false

func _ready() -> void:
	oil_bar.hide()
	health_bar_sprite.hide()
	oil_bar.max_value = max_oil
	oil_bar.value = 0

func _process(delta: float) -> void:
	if sound_playing and not begin_drill.playing and not end_drill.playing:
		end_drill.play()
	if player:
		health_bar_sprite.look_at(player.global_transform.origin, Vector3.UP)

func _on_interacted(body: Variant) -> void:
	oil_bar.show()
	health_bar_sprite.show()
	player = body
	player.spawning = true
	animation_player.play("press")
	animation_player_drill.play("drill")
	sound_playing = true
	timer.start()
	begin_drill.play()
	
func get_oil():
	var label_text = str(oil_bar.value / oil_bar.max_value * 100)
	
	oil_bar.value = oil
	
	if oil_bar.value == oil_bar.max_value:
		barrel += 1
		barrels.text = str(barrel)
		player.spawning = false
		await get_tree().create_timer(3).timeout
		oil = 0
		oil_bar.value = oil
		sound_playing = false
		oil_bar.hide()


func _on_timer_timeout() -> void:
	if player.spawning:
		oil = oil + 1
		get_oil()
		timer.start()
	else:
		animation_player_drill.stop()
		gpu_particles_3d.emitting = false
	
