extends Node

var scenes = [
	preload("res://locations/room_1.tscn").instance(),
	preload("res://locations/room_2.tscn").instance()
]

onready var main = get_tree().get_root().get_node("main")

func _ready():
	print("global loaded")
	change_scene(0)
	
func get_player():
	return main.get_player()
	
func change_scene(scene_index):
	print("change scene -> ", scene_index)
	main.set_scene(scenes[scene_index])
