class_name PlayerControls3D extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# read input pass to child nodes
	InputCollection.horizontal_direction = Input.get_axis("move_left", "move_right")
	InputCollection.vertical_direction = Input.get_axis("move_up", "move_down")
	InputCollection.jump = Input.is_action_just_pressed("jump")
