class_name PlayerControls extends Node2D

var input_collection : InputCollection = InputCollection.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in self.get_children():
		node.set_input(input_collection)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# read input pass to child nodes
	input_collection.horizontal_direction = Input.get_axis("move_left", "move_right")
	input_collection.vertical_direction = Input.get_axis("move_up", "move_down")
	input_collection.jump = Input.is_action_just_pressed("jump")
