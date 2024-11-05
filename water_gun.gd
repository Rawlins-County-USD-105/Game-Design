extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var bullet = load("res://bullet.tscn")
var instance

@onready var gun_anim = $neck/Camera/Node3D/AnimationPlayer
@onready var gun_barrel = $neck/Camera/Node3D/RayCast3D
@onready var neck: Node3D = $neck
@onready var camera: Camera3D = $neck/Camera

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	if Input.is_action_pressed("Pew"):
#			gun_anim.play("Pew")
#			instance = bullet.instantiate()
#			get_parent().add_child(instance)


func _on_timer_timeout() -> void:
	pass
