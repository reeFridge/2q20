extends Node
signal activable_triggered(instance)

enum GameState {
	None,
	Play,
	Pause
}

var game_state = GameState.None

var scenes = [
	preload("res://locations/room_1.tscn").instance(),		#0
	preload("res://locations/room_2.tscn").instance(),		#1
	preload("res://locations/street.tscn").instance(),		#2
	preload("res://locations/park.tscn").instance(),		#3
	preload("res://locations/graveyard.tscn").instance(),	#4
	preload("res://locations/crypt_1.tscn").instance(),		#5
	preload("res://locations/crypt_2.tscn").instance(),		#6
	preload("res://locations/lab.tscn").instance()			#7
]

onready var main = get_tree().get_root().get_node("main")

func notify_every_activable(instance):
	emit_signal("activable_triggered", instance)

func _ready():
	print("global loaded")
	
func get_player():
	return main.get_player()
	
func show_text(text):
	main.get_node("ui").show_text(text, 10)

func show_text_series(text_series, timeout = 10):
	main.get_node("ui").show_text_series(text_series, timeout)
	
func change_scene(scene_index, spawn_name = "spawn"):
	print("change scene -> ", scene_index)
	if main:
		main.set_scene(scenes[scene_index], spawn_name)

func take_item(item):
	main.get_node("ui/inventory").add_item(item)
	
func remove_item(item):
	main.get_node("ui/inventory").remove_item(item)

func update_active_state(item, state):
	main.get_node("ui/inventory").update_active_state(item, state)
