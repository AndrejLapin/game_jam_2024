class_name LavaHandler extends Node3D

@export var lava_float: float = 0.2
@export var health: float = 3.0

@onready var parent: RigidBody3D = get_parent()
var current_lava_float: float = 0
var in_lava: bool = false

func lava_entered():
	in_lava = true


func lava_exited():
	in_lava = false
	parent.linear_velocity.y -= current_lava_float
	current_lava_float = 0

func _physics_process(delta):
	
	if in_lava:
		health -= delta
		if health <= 0:
			parent.queue_free() # add cool death effects
		parent.linear_velocity.y += lava_float
