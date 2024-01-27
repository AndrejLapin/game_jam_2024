extends RigidBody3D

const MOVESPEED = 6.0
const JUMP_VELOCITY = 7.0
const MAX_HOLD_JUMP = 0.6
const SPAWN_WEIGHT = 1.0

var jump_held_time = 0.0


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
	
	#if InputCollection.horizontal_direction != 0 and not is_touching_floor:
		#linear_velocity.x = MOVESPEED * InputCollection.horizontal_direction
	#else:
		#linear_velocity.x = move_toward(linear_velocity.x, 0, MOVESPEED)
		
	if InputCollection.jump_held and is_touching_floor:
		jump_held_time += delta
	elif not InputCollection.jump_held and is_touching_floor and jump_held_time > 0:
		jump_held_time = clamp(jump_held_time, 0, MAX_HOLD_JUMP)
		var jump_efficiency = jump_held_time / MAX_HOLD_JUMP
		linear_velocity.y = jump_efficiency * JUMP_VELOCITY
		jump_held_time = 0
		linear_velocity.x = MOVESPEED * InputCollection.horizontal_direction * jump_efficiency
	elif is_touching_floor:
		linear_velocity.x = move_toward(linear_velocity.x, 0, delta * 100)
