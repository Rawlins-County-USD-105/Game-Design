extends Enemy

var speed = 5
var HP = 10
var rng = RandomNumberGenerator.new()
var chicken_sound

@onready var chicken_sound_1: AudioStreamPlayer3D = $ChickenSound1
@onready var chicken_sound_2: AudioStreamPlayer3D = $ChickenSound2
@onready var chicken_sound_3: AudioStreamPlayer3D = $ChickenSound3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chicken_sound = [chicken_sound_1, chicken_sound_2, chicken_sound_3]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not chicken_sound_1.playing or not chicken_sound_2.playing or not chicken_sound_3.playing:
		print("guh")
		chicken_sound_func()
	
	move(delta, speed, HP)
	if not animation.is_playing():
		animation.play("Chicken_Run")

func chicken_sound_func():
	var random_list = rng.randi_range(0, 2)
	var chicken_sound_choice = chicken_sound[random_list]
	var random_number = rng.randf_range(3.0, 10.0)

		
	await get_tree().create_timer(random_number).timeout
	chicken_sound_choice.play()
	
