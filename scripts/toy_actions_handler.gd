extends Node

func _on_toy_triggered():
	get_parent().show_actions_menu({
		examine = [self, "_on_toy_examine_action"]
	})
	
func _on_toy_examine_action(action):
	Global.show_text("such a beautiful bear even without his head. looks cute.")
	get_parent().close_actions_menu()
