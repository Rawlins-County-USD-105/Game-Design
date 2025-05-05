extends Node
var Gold = 0
var max_water = 100
var Water = max_water
var bickens = 0
var fog_density = 0.0

func Gain_Gold(Gold_Gain):
	Gold += Gold_Gain
	
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Gain_Water(Water_Gain):
	Water += Water_Gain
	if Water > max_water:
		Water = max_water
	return Water
	
func Use_Water(Water_Cost):
	if Water_Cost <= Water:
		Water -= Water_Cost
	else:
		pass
	return Water
	
