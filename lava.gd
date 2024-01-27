extends Node3D



func _on_area_3d_body_entered(body):
	for child in body.get_children():
		if not child is LavaHandler:
			continue
		child.lava_entered()
		return


func _on_area_3d_body_exited(body):
	for child in body.get_children():
		if not child is LavaHandler:
			continue
		child.lava_exited()
		return


func _on_kill_barrier_body_entered(body):
	body.queue_free()
