extends Area2D
signal triggered
signal triggered_from_inventory()

export var text = "unknown item"
export var inventory_text = ""
export var distance_to_activate = -1
export(Array, int) var episode_masks = []
export(Texture) var inventory_texture
var label: Label = null
var menu = null

func before_enter():
	if episode_masks.empty() || Stats.episode in episode_masks:
		show()
	else:
		hide()

func _process(delta):
	if menu:
		var current_distance = Global.get_player().global_position.distance_to(global_position)
		if not distance_to_activate < 0 and current_distance > distance_to_activate:
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
		Global.get_player().change_target(global_position)
		Global.get_player().min_distance_to_target = distance_to_activate
		if distance_to_activate < 0:
			emit_signal("triggered")
		else:
			Global.get_player().connect("target_changed", self, "_unsubscribe", [], CONNECT_ONESHOT)
			Global.get_player().connect("near_target", self, "_trigger", [], CONNECT_ONESHOT)

func _unsubscribe():
	if Global.get_player().is_connected("near_target", self, "_trigger"):
		Global.get_player().disconnect("near_target", self, "_trigger")

func _trigger():
	if Global.get_player().is_connected("target_changed", self, "_unsubscribe"):
		Global.get_player().disconnect("target_changed", self, "_unsubscribe")
	emit_signal("triggered")
	
func activated_from_inventory():
	emit_signal("triggered_from_inventory")

func show_actions_menu(actions):
	menu = preload("res://ui/actions_menu.tscn").instance()
	menu.init(actions)
	add_child(menu)
	var menu_rect_size = menu.get_rect().size
	menu.set_global_position(global_position - menu_rect_size)

func close_actions_menu():
	if menu != null:
		remove_child(menu)
		menu.queue_free()
		menu = null

func _on_Area2D_mouse_entered():
	label = preload("res://ui/item_label.tscn").instance()
	label.text = text
	add_child(label)
	label.set_global_position(get_global_mouse_position() - Vector2(label.rect_size.x / 2, label.rect_size.y + 10))

func _on_Area2D_mouse_exited():
	remove_child(label)
	label.queue_free()
	label = null
