class_name BackgroundClick extends Node3D

var mouse_position: Vector3

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	mouse_position = position
