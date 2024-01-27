class_name LevelGenerator extends Node3D

@export var spawer_entries: Array[PackedScene]

var rng = RandomNumberGenerator.new()
var spawn_weight_total = 0.0
var spawn_dictionary: Array[Dictionary]
var current_height = 0.0

@onready var parent: Node3D = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	# calculate total weights
	for entry in spawer_entries:
		var spawn_weight = 1.0
		var height = 2.25
		var level_block = entry.instantiate()
		if "SPAWN_WEIGHT" in level_block:
			spawn_weight = level_block.SPAWN_WEIGHT
		if "HEIGHT" in level_block:
			height = level_block.HEIGHT
		spawn_weight_total += spawn_weight
		spawn_dictionary.append({
			"character": entry,
			"weight": spawn_weight,
			"height": height
		})
		level_block.queue_free()
	generate_new_segments(10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if eliminate_first_segment():
		generate_single_segment()
	


func eliminate_first_segment() -> bool:
	var first_segment: Node3D = get_child(0)
	if first_segment == null:
		return false
	if first_segment.position.y + parent.position.y < -8:
		first_segment.queue_free()
		return true
	return false



func generate_new_segments(count: int):
	for n in count:
		generate_single_segment()


func generate_single_segment():
	var random_number = rng.randf_range(0, spawn_weight_total)
		
	var index: int = 0
	while random_number > 0:
		var entry = spawn_dictionary[index]
		random_number -= entry.weight
		if random_number <= 0:
			var level_block: Node3D = entry.character.instantiate()
			level_block.position.y = current_height
			current_height += entry.height
			add_child(level_block)
			#characterTemp.position.x = random_position
			#characterTemp.position.y = position.y
			#parent.add_child(characterTemp)
			return
		index += 1
