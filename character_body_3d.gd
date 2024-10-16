extends CharacterBody3D

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 5.0
const SENSITIVITY = 0.005

#Bob# BOB Variables
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0



#slide
var fall_distance = 0
var slide_speed = 0 
var can_slide = false
var sliding = false
var falling = false
var get_gravity = -9.8

@onready var slide: RayCast3D = $Slide

#Fov Variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5
@onready var neck: Node3D = $neck
@onready var camera: Camera3D = $neck/Camera

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is  InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
func _physics_process(delta: float) -> void:
	if falling and is_on_floor() and sliding:
		slide_speed += fall_distance / 10
	fall_distance = -get_gravity().y
		
	direction = Vector3.ZERO
	snap_vector = Vector3.DOWN
	speed = default_speed 
	 
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if not is_on_floor():
		get_gravity().x += Vector3.DOWN * gravity
		falling = true
	else:
		get_gravity() = Vector3.ZERO
		falling = false
		
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle Sprint.
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.x * speed, delta * 3.0)
		
#Heahead bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	move_and_slide()
	
	#FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
