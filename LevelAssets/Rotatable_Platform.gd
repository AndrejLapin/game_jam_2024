extends RigidBody3D
var initial_position
const ROTATION_SPEED = 0.5
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	#position.x = rng.randf_range(-5,5)
	initial_position = position

func _integrate_forces(state):
	global_rotation.x = 0
	global_rotation.y = 0
	linear_velocity.y = 0
	#linear_velocity.x = 0
	linear_velocity.z = 0
	position = initial_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
