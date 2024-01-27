extends RigidBody3D

const MOVESPEED = 15
const JUMP_VELOCITY = 30
const FRICTION = 0.5
const SPAWN_WEIGHT = 1.0
var started_jump = -1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$FloorCheck.set_as_top_level(true)


func _integrate_forces(state):
	global_rotation.x = 0
	global_rotation.y = 0
	#global_rotation.z = 0
	global_position.z = 0
	$FloorCheck.global_rotation.z = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$FloorCheck.global_transform.origin = global_transform.origin
	if started_jump == -1 and InputCollection.jump and $FloorCheck.is_colliding(): # and is_on_floor():
		started_jump = delta
	
	if InputCollection.horizontal_direction != 0:
		angular_velocity.z += -MOVESPEED * InputCollection.horizontal_direction * delta
	else:
		angular_velocity.z = move_toward(angular_velocity.z, 0, delta*MOVESPEED*2)
		
		
	if started_jump >0:
		linear_velocity.y += JUMP_VELOCITY * delta
		started_jump += delta
		
		
	if InputCollection.jump_held == false or started_jump > 0.3:
		started_jump = -1.0
	
	#linear_velocity.x = lerp(linear_velocity.x, 0.0, FRICTION)
