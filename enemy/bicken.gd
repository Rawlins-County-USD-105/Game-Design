extends Enemy

var speed = 2
var HP = 100
var rng = RandomNumberGenerator.new()
var chicken_sound
var sound_cooldown: float = 5.0
var sound_timer: float = 0.0

@onready var chicken_sound_1: AudioStreamPlayer3D = $ChickenSound1
@onready var chicken_sound_2: AudioStreamPlayer3D = $ChickenSound2
@onready var chicken_sound_3: AudioStreamPlayer3D = $ChickenSound3

func _ready() -> void:
	chicken_sound = [chicken_sound_1, chicken_sound_2, chicken_sound_3]

func _process(delta: float) -> void:
	
	sound_timer -= delta
	
	if sound_timer <= 0.0:  
		if not chicken_sound_1.playing and not chicken_sound_2.playing and not chicken_sound_3.playing:
			chicken_sound_func()
			
		sound_timer = rng.randf_range(3.0, 10.0)
	
	move(delta, speed, HP)
	if not animation.is_playing():
		animation.play("Chicken_Run")

func chicken_sound_func():
	var random_list = rng.randi_range(0, 2)
	var chicken_sound_choice = chicken_sound[random_list]
	
	chicken_sound_choice.play()
