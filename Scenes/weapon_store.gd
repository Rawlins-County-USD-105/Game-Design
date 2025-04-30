extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_water_gun_button_interacted(body: Variant) -> void:
	if not animation_player.is_playing():
		animation_player.play("water_press")
	Gain.water_gun = true


func _on_pistol_button_interacted(body: Variant) -> void:
	if not animation_player.is_playing():
		animation_player.play("pistol_press")
	Gain.pistol_gun = true

func _on_rail_gun_button_interacted(body: Variant) -> void:
	if not animation_player.is_playing():
		animation_player.play("press")
	Gain.rail_gun = true
