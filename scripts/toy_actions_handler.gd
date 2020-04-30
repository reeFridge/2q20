extends Node

func _on_toy_triggered():
	get_parent().show_actions_menu({
		examine = [self, "_on_toy_examine_action"]
	})
	
func _on_toy_examine_action(action):
	Global.show_text("He behaved so badly.")
	get_parent().close_actions_menu()
