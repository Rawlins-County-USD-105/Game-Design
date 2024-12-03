extends CharacterBody3D


@onready var neck: Node3D = $neck
@onready var body: CharacterBody3D = $"."
@onready var camera_3d: Camera3D = $neck/Camera
@onready var standing_collision_shape: CollisionShape3D = $standing_collision_shape
@onready var crouching_collision_shape: CollisionShape3D = $crouching_collision_shape
@onready var head_clearance: RayCast3D = $head_clearance



@export_category("Movement and shiz")
@export var mousesense = 1
@export var sprint = 4
@export var jump_sprint = 15


#speed
var current_speed = 5.0
var SPEED = 5.0
var crouching_speed = .5
var WALK_SPEED = 10
var lerp_speed = 30

#Bob
const BOB_FREQ = 2
const BOB_AMP = 0.1
var t_bob = 0

#FOV
const BASE_FOV = 90.0
const FOV_CHANGE = 1.5

var JUMP_VELOCITY = 5.0
var crouching_depth = -0.5

#SLiding
var slide_timer = 1
var slide_timer_max = 1
var slide_vector = Vector2.ZERO
var slide_speed = 6.0
var sliding = false



#func _enter_tree() -> void:
	#$".".set_multiplayer_authority($"..".name.to_int())
	
#func _ready() -> void:
	#camera_3d.current = is_multiplayer_authority()	

func _unhandled_input(event: InputEvent) -> void:
	#if is_multiplayer_authority():
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
		var input_dir := Input.get_vector("left", "right", "forward", "back")
		
	#if is_multiplayer_authority():
		if not is_on_floor():
			velocity += get_gravity() * delta
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		
		
		var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
		if sliding:
			#print(slide_vector)
			direction = (transform.basis * Vector3(slide_vector.x,0,slide_vector.z)).normalized()

		if direction:
		
			if sliding:
				velocity.x = direction.x * slide_timer * slide_speed
				velocity.z = direction.z * slide_timer * slide_speed
				print(str(velocity.x)+str(velocity.z))
				
				
			if Input.is_action_pressed("sprint") and is_on_floor() and not Input.is_action_pressed("crouch"):
			#Sprinting
				
		
				velocity.x = lerp(velocity.x, direction.x * SPEED * sprint,delta * 3)
				velocity.z = lerp(velocity.z, direction.z * SPEED * sprint,delta * 3)

				if Input.is_action_just_pressed("jump") and is_on_floor():
					velocity.y = JUMP_VELOCITY
			else:
				if Input.is_action_pressed("crouch") || sliding:
					current_speed = SPEED * crouching_speed
				if not Input.is_action_pressed("crouch"):
					velocity.x = lerp(velocity.x, direction.x * SPEED ,delta * 3)
					velocity.z = lerp(velocity.z, direction.z * SPEED ,delta * 3)

				else:
					velocity.x = lerp(velocity.x, direction.x * current_speed ,delta * 3)
					velocity.z = lerp(velocity.z, direction.z * current_speed ,delta * 3)


		
		if Input.is_action_just_pressed("crouch"):
			current_speed = crouching_speed
			neck.position.y = lerp(neck.position.y, 0.5 + crouching_depth, delta * lerp_speed)
			
			#slide begin
			if sprint && input_dir != Vector2.ZERO:
				sliding = true
				slide_timer - slide_timer_max
				slide_vector = direction
				print(slide_vector.y)
				print("Begin")
			
			standing_collision_shape.disabled = true
			crouching_collision_shape.disabled = false
		elif !head_clearance.is_colliding():
			standing_collision_shape.disabled = false
			crouching_collision_shape.disabled = true
			
		

	
	
			neck.position.y = lerp(neck.position.y, 0.5, delta * lerp_speed)

		velocity.x = lerp(velocity.x, direction.x * SPEED ,delta * 10)
		velocity.z = lerp(velocity.z, direction.z * SPEED ,delta * 10)

		if sliding:
			slide_timer -= delta
			if slide_timer <= 0:
				sliding = false
				slide_timer = 2.0
				print("End")
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
