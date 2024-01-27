extends RigidBody2D

const MOVESPEED = 300
const JUMP_VELOCITY = -500

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func _integrate_forces(state):
	global_rotation = 0
	#rotation_degree = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if InputCollection.horizontal_direction != 0:
		linear_velocity.x = MOVESPEED * InputCollection.horizontal_direction
	else:
		linear_velocity.x = move_toward(linear_velocity.x, 0, MOVESPEED)
		
	if InputCollection.jump: # and is_on_floor():
		linear_velocity.y = JUMP_VELOCITY
	#else:
		#linear_velocity.y += gravity * delta
		
	# move_and_collide()

