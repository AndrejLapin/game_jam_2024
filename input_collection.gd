extends Node3D

var horizontal_direction: float = 0
var vertical_direction: float = 0
var mouse_just_pressed: bool = false
var jump: bool = false
var jump_held: bool = false
var mouse_position: Vector2 = Vector2(0.0, 0.0)
var rayOrigin: Vector3 = Vector3()
var rayEnd: Vector3 = Vector3()

@onready var backgroundClick: BackgroundClick = $"../mainScene3D/BackgroundClick"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _input(event):
	#if event is InputEventMouseMotion:
		#mouse_position = event.position


func _physics_process(delta):
	# read input pass to child nodes
	horizontal_direction = Input.get_axis("move_left", "move_right")
	vertical_direction = Input.get_axis("move_up", "move_down")
	
	mouse_just_pressed = Input.is_action_just_pressed("mouse_click")
		
	mouse_position.x = backgroundClick.mouse_position.x
	mouse_position.y = backgroundClick.mouse_position.y
	if Input.is_action_just_pressed("jump"):
		jump = true
		jump_held = true
	else:
		jump = false
	
	if Input.is_action_just_released("jump"):
		jump_held = false

