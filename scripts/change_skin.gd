extends Node

func before_enter():
	var player = Global.get_player()
	player.walk_animation = "bandage_walk"
	player.stand_animation = "bandage_stand"
	var inventory = Global.main.get_node("ui/inventory")
	for i in inventory.items:
		Global.remove_item(i)
	
	var timer = Timer.new()
	timer.connect("timeout", self, "timeout")
	timer.one_shot = true
	timer.wait_time = 10
	timer.autostart = true
	add_child(timer)

func timeout():
	get_tree().quit(0)
