extends Node

export var text = ""

func _on_triggered():
	Global.show_text(text)
	get_parent().close_actions_menu()
