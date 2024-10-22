extends CharacterBody3D


@onready var neck: Node3D = $neck
@onready var body: CharacterBody3D = $"."
@onready var camera_3d: Camera3D = $neck/Camera
@onready var standing_collison_shape = $CollisionShape3D
@onready var crouching_collision_shape = $crouching_collision_shape

@export_category("Movement and shiz")
@export var mousesense = 1
@export var sprint = 2
@export var jump_sprint = 15

var current_speed = 5.0
var SPEED = 5.0
const BOB_FREQ = 2
const BOB_AMP = 0.1
var t_bob = 0
const BASE_FOV = 90.0
const FOV_CHANGE = 1.5
var JUMP_VELOCITY = 5.0
var crouching_speed = .5
var crouching_depth = -0.5
var lerp_speed = 30
var WALK_SPEED = 10


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
		
		if Input.is_action_pressed("sprint") and is_on_floor() and not Input.is_action_pressed("crouch"):
			velocity.x = lerp(velocity.x, direction.x * SPEED * sprint,delta * 3)
			velocity.z = lerp(velocity.z, direction.z * SPEED * sprint,delta * 3)

			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
		else:
			if Input.is_action_pressed("crouch"):
				current_speed = SPEED * crouching_speed
			if not Input.is_action_pressed("crouch"):
				velocity.x = lerp(velocity.x, direction.x * SPEED ,delta * 3)
				velocity.z = lerp(velocity.z, direction.z * SPEED ,delta * 3)

			else:
				velocity.x = lerp(velocity.x, direction.x * current_speed ,delta * 3)
				velocity.z = lerp(velocity.z, direction.z * current_speed ,delta * 3)



	else:
		if Input.is_action_pressed("crouch"):
			current_speed = crouching_speed
			neck.position.y = lerp(neck.position.y, 1.006 + crouching_depth, delta * lerp_speed)
			standing_collison_shape.set_deferred("disable",true)
			crouching_collision_shape.set_deferred("disable",false)
		else:
			standing_collison_shape.set_deferred("disable", false)
			crouching_collision_shape.set_deferred("disable", true)
			neck.position.y = lerp(neck.position.y, 1.006, delta * lerp_speed)
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
	
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	print("gfaggdsagds")
