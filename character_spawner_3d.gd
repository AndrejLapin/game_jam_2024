class_name CharacterSpawner extends Node3D


const SPAWN_INTERVAL_PLACEHOLDER = 5.0

@export var world: Node3D
@export var spawer_entries: Array[PackedScene]

var rng = RandomNumberGenerator.new()
var elapsed_spawn_time = 0.0
var spawn_weight_total = 0.0
var spawn_dictionary: Array[Dictionary]

@onready var half_length: float = (get_node("Area3D/CollisionShape3D").shape.size.x / 2)
var character_group: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	character_group = Node3D.new()
	character_group.name = "CharacterGroup"
	world.add_child(character_group)
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
	generate_characters(5)


func _physics_process(delta):
	elapsed_spawn_time += delta
	if elapsed_spawn_time >= SPAWN_INTERVAL_PLACEHOLDER:
		generate_character()
		elapsed_spawn_time = 0
	pass


func generate_characters(count: int):
	for n in count:
		generate_character()


func generate_character():
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
			character_group.add_child(characterTemp)
			return
		index += 1
