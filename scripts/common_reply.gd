extends Node

export var text = ""
export(Array, String) var texts = []

func _on_triggered():
	if texts.empty():
		Global.show_text(text)
	else:
		Global.show_text_series(texts)
	get_parent().close_actions_menu()
