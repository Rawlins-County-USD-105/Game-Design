extends SpotLight3D

# Flicker settings
@export var min_energy: float = 0.1
@export var max_energy: float = 0.5
@export var min_flicker_duration: float = 0.5  # How long the flicker lasts
@export var max_flicker_duration: float = 1.5  # How long the flicker lasts
@export var min_flicker_delay: float = 0.5
@export var max_flicker_delay: float = 3


# Internal variables
var _base_energy: float
var _flicker_timer: float = 0.0
var _is_flickering: bool = false
var _flicker_time_left: float = 0.0

func _ready():
	_base_energy = light_energy
	_schedule_next_flicker()

func _process(delta):
	if _is_flickering:
		_flicker_time_left -= delta
		if _flicker_time_left <= 0.0:
			light_energy = _base_energy  # Reset to normal
			_is_flickering = false
			_schedule_next_flicker()
		else:
			pass
	else:
		_flicker_timer -= delta
		if _flicker_timer <= 0.0:
			_start_flicker()

func _schedule_next_flicker():
	_flicker_timer = randf_range(min_flicker_delay, max_flicker_delay)

func _start_flicker():
	_is_flickering = true
	_flicker_time_left = randf_range(min_flicker_duration, max_flicker_duration)
	light_energy = _base_energy * randf_range(min_energy, max_energy)
