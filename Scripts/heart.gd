extends Area2D

func _on_body_entered(body):
	queue_free()
	print("destroy_heart_body")
	var hearts = get_tree().get_nodes_in_group("Hearts")
	if hearts.size() == 1:
		Events.level_completed.emit()


func _on_area_entered(area):
	queue_free()
	print("destroy_heart")
	var hearts = get_tree().get_nodes_in_group("Hearts")
	if hearts.size() == 1:
		Events.level_completed.emit()
