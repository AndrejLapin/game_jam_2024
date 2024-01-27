extends RigidBody3D

const MOVESPEED = 5
const JUMP_VELOCITY = 5


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
	
	if InputCollection.horizontal_direction != 0:
		linear_velocity.x = MOVESPEED * InputCollection.horizontal_direction
	else:
		linear_velocity.x = move_toward(linear_velocity.x, 0, MOVESPEED)
		
	if InputCollection.jump and $FloorCheck.is_colliding(): # and is_on_floor():
		linear_velocity.y = JUMP_VELOCITY
