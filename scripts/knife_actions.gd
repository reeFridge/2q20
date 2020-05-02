extends Node

var equiped = false

func _on_triggered():
	get_parent().show_actions_menu({
		examine = [self, "_on_examine"],
		take = [self, "_on_take"]
	})
	
func _ready():
	get_parent().connect("triggered_from_inventory", self, "_on_triggered_from_inventory")

func _on_triggered_from_inventory():
	equiped = !equiped
	Global.get_player().equip_knife(equiped)
	Global.update_active_state(get_parent(), equiped)


func remove_from_scene():
	var parent = get_parent()
	parent.close_actions_menu()
	parent.get_parent().remove_child(parent)
	return parent
	
func _on_examine(action):
	Global.show_text("sharp bloody knife.")
	get_parent().close_actions_menu()

func _on_take(action):
	var parent = remove_from_scene()
	Global.take_item(parent)
