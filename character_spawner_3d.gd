class_name CharacterSpawner extends Node3D


const SPAWN_INTERVAL_PLACEHOLDER = 5.0

@export var spawer_entries: Array[PackedScene]

var rng = RandomNumberGenerator.new()
var elapsed_spawn_time = 0.0
var spawn_weight_total = 0.0
var spawn_dictionary: Array[Dictionary]

@onready var parent: Node = get_parent()
@onready var half_length: float = (get_node("Area3D/CollisionShape3D").shape.size.x / 2)

# Called when the node enters the scene tree for the first time.
func _ready():
	# calculate total weights
	for entry in spawer_entries:
		var spawn_weight = 1.0
		var char = entry.instantiate()
		if "SPAWN_WEIGHT" in char:
			spawn_weight = char.SPAWN_WEIGHT
		spawn_weight_total += spawn_weight
		spawn_dictionary.append({
			"character": entry,
			"weight": spawn_weight
		})
		char.queue_free()


func _physics_process(delta):
	elapsed_spawn_time += delta
	if elapsed_spawn_time >= SPAWN_INTERVAL_PLACEHOLDER:
		elapsed_spawn_time = 0
		var random_number = rng.randf_range(0, spawn_weight_total)
		var random_position = rng.randf_range(-half_length, half_length)
		
		var index: int = 0
		while random_number > 0:
			var entry = spawn_dictionary[index]
			random_number -= entry.weight
			if random_number <= 0:
				var characterTemp: Node3D = entry.character.instantiate()
				characterTemp.position.x = random_position
				characterTemp.position.y = position.y
				parent.add_child(characterTemp)
				return
			index += 1
	pass
