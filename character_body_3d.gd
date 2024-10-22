extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
#character

@onready var neck: Node3D = $neck
@onready var camera: Camera3D = $neck/Camera
@onready var gun_anim = $neck/Camera/Gun/Model/AnimationPlayer
@onready var gun_barrel = $neck/Camera/Gun/RayCast3D

=======
@onready var body: CharacterBody3D = $neck
@onready var camera_3d: Camera3D = $neck/Camera

@export_category("Movement and shiz")
@export var mousesense = 1
@export var sprint = 2
@export var jump_sprint = 15

const BOB_FREQ = 2
const BOB_AMP = 0.1
var t_bob = 0
const BASE_FOV = 90.0
const FOV_CHANGE = 1.5


>>>>>>> main


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01 * mousesense)
			camera_3d.rotate_x(-event.relative.y * 0.01 * mousesense)
			camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-60), deg_to_rad(60))
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
		
	if direction:
		if Input.is_action_pressed("sprint") and is_on_floor():
			velocity.x = lerp(velocity.x, direction.x * SPEED * sprint,delta * 3)
			velocity.z = lerp(velocity.z, direction.z * SPEED * sprint,delta * 3)
			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
		else:
			velocity.x = lerp(velocity.x, direction.x * SPEED ,delta * 3)
			velocity.z = lerp(velocity.z, direction.z * SPEED ,delta * 3)
	else:
		velocity.x = lerp(velocity.x, direction.x * SPEED ,delta * 10)
		velocity.z = lerp(velocity.z, direction.z * SPEED ,delta * 10)

	t_bob += delta * velocity.length() * float(is_on_floor())
	camera_3d.transform.origin = _headbob(t_bob)
	move_and_slide()
	
	#FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, sprint * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera_3d.fov = lerp(camera_3d.fov, target_fov, delta * 8.0)
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	print(pos.y)
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

	#Shooting
	if Input.is_action_pressed("Shoot"):
		if !gun_anim.is_playing():
			gun_anim.play("Shoot")
