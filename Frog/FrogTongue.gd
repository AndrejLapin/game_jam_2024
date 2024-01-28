extends Node3D

@onready var parent: Node3D = get_parent().get_parent().get_parent()
@onready var tip_position_node: Node3D = $Tongue/TipPosition
@onready var hit: bool = false

func _on_area_3d_body_entered(body):
	if body != parent and not hit:
		hit = true
		parent.tongue_hit(body, tip_position_node.global_position)
