extends Node

var horizontal_direction: float = 0
var vertical_direction: float = 0
var jump: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	# read input pass to child nodes
	horizontal_direction = Input.get_axis("move_left", "move_right")
	vertical_direction = Input.get_axis("move_up", "move_down")
	jump = Input.is_action_just_pressed("jump")
