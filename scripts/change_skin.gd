extends Node

func before_enter():
	var player = Global.get_player()
	player.walk_animation = "bandage_walk"
	player.stand_animation = "bandage_stand"
	var inventory = Global.main.get_node("ui/inventory")
	for i in inventory.items:
		Global.remove_item(i)
