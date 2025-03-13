extends Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player_drill: AnimationPlayer = $"../AnimationPlayer"
@onready var oil_bar: ProgressBar = $"../OilBar"
@onready var label: Label = $"../OilBar/Label"

var oil = 0
var max_oil = 1000

func _on_interacted(body: Variant) -> void:
	body.spawning = true
	animation_player.play("press")
	animation_player_drill.play("drill")

func get_oil(player):
	var label_text = str(oil_bar.value / oil_bar.max_value)
	label.text = label_text + "%"
	
	
	
	if oil_bar.value == oil_bar.max_value:
		player.spawning = false
