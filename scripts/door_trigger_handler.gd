extends Node

export var scene_index = 0
export var scene_spawn = "spawn"
export(Array, int) var episode_masks = []
export var inventory_mask = ""

func _on_triggered():
	if episode_masks.empty() || Stats.episode in episode_masks:
		if Global.main.get_node("ui/inventory").has_item(inventory_mask) || inventory_mask.empty():
			Global.change_scene(scene_index, scene_spawn)
		else:
			Global.show_text("I need " + "[color=#80170F]" + inventory_mask + "[/color]", 10, true)
