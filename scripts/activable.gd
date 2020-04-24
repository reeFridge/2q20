extends Area2D
signal triggered

export var text = "unknown item"
export var distance_to_activate = -1
var label: Label = null
var menu = null

func _process(delta):
	if menu:
		var current_distance = Global.get_player().global_position.distance_to(global_position)
		if current_distance > distance_to_activate:
			close_actions_menu()

func _ready():
	Global.connect("activable_triggered", self, "_on_some_activable_triggered")
	
func _on_some_activable_triggered(instance):
	if instance != self:
		close_actions_menu()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion && label != null:
		label.set_global_position(get_global_mouse_position() - Vector2(label.rect_size.x / 2, label.rect_size.y + 10))
	if event is InputEventMouseButton and event.pressed:
		close_actions_menu()
		Global.notify_every_activable(self)
		if distance_to_activate < 0:
			emit_signal("triggered")
		else:
			var current_distance = Global.get_player().global_position.distance_to(global_position)
			if current_distance <= distance_to_activate:
				emit_signal("triggered")

func show_actions_menu(actions):
	menu = preload("res://ui/actions_menu.tscn").instance()
	menu.init(actions)
	add_child(menu)
	menu.set_global_position(get_global_mouse_position())

func close_actions_menu():
	if menu != null:
		remove_child(menu)
		menu.queue_free()
		menu = null

func _on_Area2D_mouse_entered():
	label = preload("res://ui/item_label.tscn").instance()
	label.text = text
	add_child(label)

func _on_Area2D_mouse_exited():
	remove_child(label)
	label.queue_free()
	label = null
