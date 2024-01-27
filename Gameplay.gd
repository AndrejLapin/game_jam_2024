extends Node3D

@export var world: Node3D
@export var character_spawner: Node3D
@export var temp_objects: Array[Node3D]
@export var play: bool = true
@export var initial_speed: float = 0.1 # this can be lava speed
@export var speed_up: float = 0.2

var current_speed = initial_speed

func _process(delta):
	var position_delta = current_speed * delta
	world.position.y -= position_delta
	#camera.position.y += position_delta
	#character_spawner.position.y += position_delta
	#for node in temp_objects:
		#node.position.y += position_delta
	#current_speed += speed_up * delta
	# we need to generate new segments
