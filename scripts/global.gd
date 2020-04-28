extends Node
signal activable_triggered(instance)

var scenes = [
	preload("res://locations/room_1.tscn").instance(),
	preload("res://locations/room_2.tscn").instance(),
	preload("res://locations/street.tscn").instance(),
	preload("res://locations/park.tscn").instance(),
	preload("res://locations/graveyard.tscn").instance()
]

onready var main = get_tree().get_root().get_node("main")

func notify_every_activable(instance):
	emit_signal("activable_triggered", instance)

func _ready():
	print("global loaded")
	change_scene(4)
	
func get_player():
	return main.get_player()
	
func show_text(text):
	main.get_node("ui").show_text(text, 5)
	
func change_scene(scene_index, spawn_name = "spawn"):
	print("change scene -> ", scene_index)
	if main:
		main.set_scene(scenes[scene_index], spawn_name)
		
func take_item(item):
	main.get_node("ui").get_node("inventory").add_item(item)
