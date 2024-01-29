extends Node3D

@export var world: Node3D
@export var level_generator: LevelGenerator
@export var character_spawner: Node3D
@export var play: bool = true
@export var initial_speed: float = 0.1 # this can be lava speed
@export var speed_up: float = 0.2

var current_speed = initial_speed

func _physics_process(delta):
	if not play: # for testing
		return
	
	var position_delta = current_speed * delta
	world.position.y -= position_delta
	current_speed += speed_up * delta
