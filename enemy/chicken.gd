extends Enemy

var speed = 5
var HP = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move(delta, speed, HP)
	if not animation.is_playing():
		animation.play("Chicken_Run")

	
	
