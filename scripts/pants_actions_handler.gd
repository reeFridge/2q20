extends Node

func _on_pants_triggered():
	get_parent().show_actions_menu({
		examine = [self, "_on_pants_examine_action"],
		take = [self, "_on_take"]
	})
	
func _on_pants_examine_action(action):
	Global.show_text("oh... i guess it's deserve some explanation.")
	get_parent().close_actions_menu()

func _on_take(action):
	var parent = get_parent()
	parent.close_actions_menu()
	parent.get_parent().remove_child(parent)
	Global.take_item(parent)
