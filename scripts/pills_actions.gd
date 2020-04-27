extends Node

func _on_triggered():
	get_parent().show_actions_menu({
		examine = [self, "_on_examine"],
		use = [self, "_on_use"],
		take = [self, "_on_take"]
	})
	
func remove_from_scene():
	var parent = get_parent()
	parent.close_actions_menu()
	parent.get_parent().remove_child(parent)
	return parent
	
func _on_examine(action):
	Global.show_text("pills helps me feeling well.")
	get_parent().close_actions_menu()
	
func _on_use(action):
	remove_from_scene()
	Stats.update_mental(10)

func _on_take(action):
	var parent = remove_from_scene()
	Global.take_item(parent)
