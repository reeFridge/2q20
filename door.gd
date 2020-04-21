extends Area2D

export var text = "unknown item"

func _ready():
	$Label.text = text
	$Label.visible = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion && $Label.visible:
		$Label.set_global_position(get_global_mouse_position() - Vector2($Label.rect_size.x / 2, $Label.rect_size.y + 10))
	if event is InputEventMouseButton and event.pressed:
		print("trigger: ", text)

func _on_Area2D_mouse_entered():
	$Label.visible = true
	pass # Replace with function body.

func _on_Area2D_mouse_exited():
	$Label.visible = false
	pass # Replace with function body.
