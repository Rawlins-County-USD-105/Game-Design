extends SpotLight3D

# Flicker settings
@export var min_energy: float = 0.5
@export var max_energy: float = 1.5
@export var flicker_speed: float = 10.0  # How fast the flicker happens
@export var flicker_variation: float = 0.2  # How much variation in timing

# Internal variables
var _base_energy: float
var _time: float = 0.0
var _random_offset: float

func _ready():
	# Store the original energy level
	_base_energy = light_energy
	# Create a random offset so not all lights flicker in sync
	_random_offset = randf_range(0.0, 100.0)

func _process(delta):
	_time += delta
	
	# Calculate flicker effect using noise for more natural randomness
	var noise = sin((_time + _random_offset) * flicker_speed * (1.0 + randf() * flicker_variation))
	# Map the noise from [-1, 1] to [min_energy, max_energy]
	var energy_scale = remap(noise, -1.0, 1.0, min_energy, max_energy)
	
	# Apply to the light
	light_energy = _base_energy * energy_scale
