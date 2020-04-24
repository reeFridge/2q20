extends Node

func _on_toy_triggered():
	get_parent().show_actions_menu({
		examine = [self, "_on_toy_examine_action"],
		take = [self, "_on_toy_take_action"]
	})
	
func _on_toy_examine_action(action):
	Global.show_text("such a beautiful bear even without his head. looks cute.")
	get_parent().close_actions_menu()

func _on_toy_take_action(action):
	Global.show_text("i can't take it.")
	get_parent().close_actions_menu()
