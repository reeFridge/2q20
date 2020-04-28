extends Node

func _on_parents_room_triggered():
	Global.show_text("i don't want go there!")
	get_parent().close_actions_menu()
