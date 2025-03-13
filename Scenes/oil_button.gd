extends Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player_drill: AnimationPlayer = $"../AnimationPlayer"
@onready var oil_bar: ProgressBar = $"../OilBar"
@onready var label: Label = $"../OilBar/Label"
@onready var timer: Timer = $"../Timer"

var oil = 0
var max_oil = 1000
var player = null

func _ready() -> void:
	oil_bar.hide()
	label.text = ""
	oil_bar.max_value = max_oil
	oil_bar.value = 0

func _on_interacted(body: Variant) -> void:
	oil_bar.show()
	player = body
	player.spawning = true
	animation_player.play("press")
	animation_player_drill.play("drill")
	timer.start()

func get_oil():
	var label_text = str(oil_bar.value / oil_bar.max_value * 100)
	label.text = label_text + "%"
	
	oil_bar.value = oil
	
	if oil_bar.value == oil_bar.max_value:
		label.text = "100%"
		player.spawning = false


func _on_timer_timeout() -> void:
	if player.spawning:
		oil = oil + 1
		get_oil()
		timer.start()
	else:
		animation_player_drill.stop()
