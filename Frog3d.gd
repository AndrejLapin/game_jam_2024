extends RigidBody3D

@export var tongue_mesh: PackedScene

const AREAL_STRAFE = 4.0
const MOVESPEED = 2.0
const JUMP_VELOCITY = 14.0
const MAX_HOLD_JUMP = 0.6
const SPAWN_WEIGHT = 1.1

var jump_held_time = 0.0
var jump_strafe_velocity: float = 0.0
var tongue_target: Vector2 = Vector2(0.0, 0.0)
var previous_tongue: Node3D = null

@onready var original_bounce: float = physics_material_override.bounce


# Called when the node enters the scene tree for the first time.
func _ready():
	$FloorCheck.set_as_top_level(true)


func _integrate_forces(state):
	global_rotation.x = 0
	global_rotation.y = 0
	global_rotation.z = 0
	global_position.z = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$FloorCheck.global_transform.origin = global_transform.origin
	
	var is_touching_floor = $FloorCheck.is_colliding()
	
	if InputCollection.mouse_just_pressed:
		if previous_tongue != null:
			previous_tongue.queue_free()
		var world_pos = Vector2(global_position.x, global_position.y)
		var angle = (world_pos - InputCollection.mouse_position).angle()
		var tongue: Node3D = tongue_mesh.instantiate()
		tongue.rotation.z = angle + deg_to_rad(90)
		tongue.scale.y = 1000
		previous_tongue = tongue
		add_child(tongue)

	if is_touching_floor:
		if InputCollection.jump_held:
			jump_held_time += delta
		elif not InputCollection.jump_held and jump_held_time > 0:
			jump_held_time = clamp(jump_held_time, 0, MAX_HOLD_JUMP)
			var jump_efficiency = jump_held_time / MAX_HOLD_JUMP
			linear_velocity.y = jump_efficiency * JUMP_VELOCITY
			jump_held_time = 0
			jump_strafe_velocity = MOVESPEED * InputCollection.horizontal_direction * jump_efficiency
			linear_velocity.x = jump_strafe_velocity
			
		if linear_velocity.y <= 0:
			physics_material_override.bounce = 0.0
		else:
			physics_material_override.bounce = original_bounce
		linear_velocity.x = move_toward(linear_velocity.x, 0, delta * 100)
	else:
		linear_velocity.x = jump_strafe_velocity + InputCollection.horizontal_direction * AREAL_STRAFE
