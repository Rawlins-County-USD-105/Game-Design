extends CharacterBody3D

@export var locomotion : String
@export var animationTree : AnimationTree
@export var transitionSpeed : float = 0.1
@export var SPEED: float = 5.0
@export var JUMP_VELOCITY: float = 4.5
@export var mousesense: float = 1
@onready var camera_3d: Camera3D = $funnyshid/Armature/Skeleton3D/Camera

@onready var player: CharacterBody3D = $"."

func _unhandled_input(event: InputEvent) -> void:
	#if is_multiplayer_authority():
		if event is InputEventMouseButton:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		elif event.is_action_pressed("ui_cancel"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			if event is InputEventMouseMotion:
				player.rotate_y(-event.relative.x * 0.01 * mousesense)
				
				camera_3d.rotate_x(-event.relative.y * 0.01 * mousesense)
				camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-80), deg_to_rad(80))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

var currentInput : Vector2
var currentVelocity : Vector2

func _process(delta):
	animationTree.set(locomotion, currentInput)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	currentInput = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var direction = (transform.basis * Vector3(currentInput.x, 0, currentInput.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
