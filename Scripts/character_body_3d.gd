extends CharacterBody3D
var max_health = 400
var health = max_health
@onready var neck: Node3D = $neck
@onready var body: CharacterBody3D = $"."
@onready var camera_3d: Camera3D = $neck/Camera
@onready var standing_collision_shape: CollisionShape3D = $standing_collision_shape
@onready var crouching_collision_shape: CollisionShape3D = $crouching_collision_shape
@onready var head_clearance: RayCast3D = $head_clearance
@onready var regen: Timer = $Regen
@onready var regen_interval: Timer = $"Regen Interval"
@onready var healthbar: ProgressBar = $neck/Camera/TextureRect/Healthbar
@onready var energybar: ProgressBar = $neck/Camera/TextureRect/Energybar

#Enemy Spawn
@onready var spawner: Node3D = $"../../SpawnHolder"
@onready var spawn_point: Marker3D = $"Spawner/Spawn Point"
@onready var enemy = preload("res://enemy/Bean.tscn")
@onready var group_enemy = $"../../Enemys"
var rand_spawn_time = RandomNumberGenerator.new()



@export_category("Movement and shiz")
@export var mousesense = 1
@export var sprint = 4
@export var jump_sprint = 15

#Weapons
@onready var Watergun = $neck/Camera/Watergun
@onready var Shovel = $"neck/Camera/Root Scene" 
var current_weapopn = 1

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

var JUMP_VELOCITY = 5
var crouching_depth = -0.5

#SLiding
var slide_timer = 1.0
var slide_timer_max = 1.0
var slide_vector = Vector2.ZERO
var slide_speed = 10.0
var sliding = false

#fall damage
var old_vel = 0.0
var fall_hurtie = 10.0


func Weapon_Select():
	if Input.is_action_just_pressed("Watergun"):
		current_weapopn = 1
	elif Input.is_action_just_pressed("Shovel"):
		current_weapopn = 2
	elif Input.is_action_just_pressed("Weapon3"):
		current_weapopn = 3
	if current_weapopn == 1:
		Watergun.visible = true
	else:
		Watergun.visible = false
	if current_weapopn == 2:
		Shovel.visible = true
	else:
		Shovel.visible = false
	#if current_weapopn == 3:
#		Weapon3.visible = true
	#else:
	#	Weapon3.visible = false



#func _enter_tree() -> void:
	#$".".set_multiplayer_authority($"..".name.to_int())
	
func _ready() -> void:
	#camera_3d.current = is_multiplayer_authority()
	healthbar.max_value = max_health
	healthbar.value = health
	
func took_damage(Damage):
	if Damage > health:
		health = 0
	else:
		health -= Damage
	if health <= 0:
		print("You Died")
	healthbar.value = health
	regen.start()
	
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
	if Input.is_action_just_pressed("jump") and is_on_floor() && !sliding:
		velocity.y = JUMP_VELOCITY
	Weapon_Select()
	#regen

	if regen.is_stopped() and regen_interval.is_stopped() and health < max_health:
		health += 5
		healthbar.value = health
		regen_interval.start()
	energybar.value = Gain.Water

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
		
		
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
	if sliding:
		direction = (transform.basis * Vector3(slide_vector.x,0,slide_vector.z)).normalized()
		
	if direction:
		
		if sliding:

			velocity.x = direction.x * slide_timer * slide_speed
			velocity.z = direction.z * slide_timer * slide_speed

				
				
		if Input.is_action_pressed("sprint") and is_on_floor() and not Input.is_action_pressed("crouch"):
		#Sprinting
				
		
			velocity.x = lerp(velocity.x, direction.x * SPEED * sprint,delta * 3)
			velocity.z = lerp(velocity.z, direction.z * SPEED * sprint,delta * 3)
 
			if Input.is_action_just_pressed("jump") and is_on_floor() and !sliding:
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
	if Input.is_action_just_pressed("crouch") && Input.is_action_pressed("sprint") && is_on_floor():
		if sprint && input_dir != Vector2.ZERO:
			sliding = true
			@warning_ignore("standalone_expression")
			slide_timer - slide_timer_max
			slide_vector = direction

		
	if Input.is_action_pressed("crouch"):
		current_speed = crouching_speed
		neck.position.y = lerp(neck.position.y, 0.5 + crouching_depth, delta * lerp_speed)
		#slide begin
		standing_collision_shape.disabled = true
		crouching_collision_shape.disabled = false
	elif sliding == true:
		neck.position.y = lerp(neck.position.y, 0.5 + crouching_depth, delta * lerp_speed)
		#slide begin
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
			slide_timer = 1.0

	t_bob += delta * velocity.length() * float(is_on_floor())
	camera_3d.transform.origin = _headbob(t_bob)
	move_and_slide()
	
	#fall damage
	if old_vel < 0:
		var diff = velocity.y - old_vel
		if diff > fall_hurtie:
			took_damage(round(diff))
	old_vel = velocity.y
	
	#FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, sprint * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera_3d.fov = lerp(camera_3d.fov, target_fov, delta * 8.0)

	spawner.rotate_y(deg_to_rad(30))
	
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

func _on_spawn_timer_timeout() -> void:
	var e_inst = enemy.instantiate()
	e_inst.player = self
	e_inst.position = spawn_point.global_position
	group_enemy.add_child(e_inst)
