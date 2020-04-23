extends Area2D
signal triggered

export var text = "unknown item"
export var distance_to_activate = -1
var label: Label = null

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion && label != null:
		label.set_global_position(get_global_mouse_position() - Vector2(label.rect_size.x / 2, label.rect_size.y + 10))
	if event is InputEventMouseButton and event.pressed:
		if distance_to_activate < 0:
			emit_signal("triggered")
		else:
			var current_distance = Global.get_player().global_position.distance_to(global_position)
			if current_distance <= distance_to_activate:
				emit_signal("triggered")

func _on_Area2D_mouse_entered():
	label = preload("res://ui/item_label.tscn").instance()
	label.text = text
	add_child(label)

func _on_Area2D_mouse_exited():
	remove_child(label)
	label.queue_free()
	label = null
