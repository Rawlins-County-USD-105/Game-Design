extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var model: MeshInstance3D = $Model
@onready var pistol: Node3D = $pistol
@onready var rail_gun: Node3D = $railme
@onready var water_gun_button: StaticBody3D = $Water_Gun_Button
@onready var pistol_button: StaticBody3D = $Pistol_Button
@onready var rail_gun_button: StaticBody3D = $Rail_Gun_Button

func _on_water_gun_button_interacted(body: Variant) -> void:
	if Gain.Gold >= 200 and not Gain.water_gun:
		if not animation_player.is_playing():
			animation_player.play("water_press")
		Gain.water_gun = true
		body.current_weapopn = 1
		Gain.Gain_Gold(-200)
		model.hide()
		water_gun_button.prompt = ""
		water_gun_button.prompt_input = ""


func _on_pistol_button_interacted(body: Variant) -> void:
	if Gain.Gold >= 100  and not Gain.pistol_gun:
		if not animation_player.is_playing():
			animation_player.play("pistol_press")
		Gain.pistol_gun = true
		body.current_weapopn = 3
		Gain.Gain_Gold(-100)
		pistol.hide()
		pistol_button.prompt = ""
		pistol_button.prompt_input = ""
	
func _on_rail_gun_button_interacted(body: Variant) -> void:
	if Gain.Gold >= 2000  and not Gain.rail_gun:
		if not animation_player.is_playing():
			animation_player.play("press")
		Gain.rail_gun = true
		body.current_weapopn = 4
		Gain.Gain_Gold(-2000)
		rail_gun.hide()
		rail_gun_button.prompt = ""
		rail_gun_button.prompt_input = ""
