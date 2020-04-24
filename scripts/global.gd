extends Node
signal activable_triggered(instance)

var scenes = [
	preload("res://locations/room_1.tscn").instance(),
	preload("res://locations/room_2.tscn").instance()
]

onready var main = get_tree().get_root().get_node("main")

func notify_every_activable(instance):
	emit_signal("activable_triggered", instance)

func _ready():
	print("global loaded")
	change_scene(0)
	
func get_player():
	return main.get_player()
	
func show_text(text):
	main.get_node("ui").show_text(text, 5)
	
func change_scene(scene_index, spawn_name = "spawn"):
	print("change scene -> ", scene_index)
	if main:
		main.set_scene(scenes[scene_index], spawn_name)
