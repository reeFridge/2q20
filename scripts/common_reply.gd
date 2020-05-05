extends Node

export var text = ""
export(Array, String) var texts = []
export(bool) var once = false

func _on_triggered():
	if texts.empty():
		Global.show_text(text)
	else:
		Global.show_text_series(texts)
	get_parent().close_actions_menu()
	
	var item = get_node_or_null("item")
	if item != null:
		Global.take_item(item)

	if once:
		if get_parent().is_connected("triggered", self, "_on_triggered"):
			get_parent().disconnect("triggered", self, "_on_triggered")
		get_parent().remove_child(self)

