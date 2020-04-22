extends Area2D
signal triggered

export var text = "unknown item"
export var distance_to_activate = -1

func _ready():
	$Label.text = text
	$Label.visible = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion && $Label.visible:
		$Label.set_global_position(get_global_mouse_position() - Vector2($Label.rect_size.x / 2, $Label.rect_size.y + 10))
	if event is InputEventMouseButton and event.pressed:
		if distance_to_activate < 0:
			emit_signal("triggered")
		else:
			var current_distance = Global.get_player().global_position.distance_to(global_position)
			if current_distance <= distance_to_activate:
				emit_signal("triggered")

func _on_Area2D_mouse_entered():
	$Label.visible = true
	pass # Replace with function body.

func _on_Area2D_mouse_exited():
	$Label.visible = false
	pass # Replace with function body.
