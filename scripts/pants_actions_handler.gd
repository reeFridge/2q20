extends Node

func _on_pants_triggered():
	get_parent().show_actions_menu({
		examine = [self, "_on_pants_examine_action"]
	})
	
func _on_pants_examine_action(action):
	Global.show_text("oh... i guess it's deserve some explanation.")
	get_parent().close_actions_menu()
