extends Node2D

onready var player = preload("res://player/player.tscn").instance()
var spawn_name = "spawn"
export var fade = false
var ready = false

func _ready():
	var cam = $cam
	cam.current = true
	remove_child($cam)
	player.add_child(cam)
	player.maxBottom = $max_bottom.get_path()
	player.maxTop = $max_top.get_path()
	player.maxLeft = $max_left.get_path()
	player.maxRight = $max_right.get_path()
	add_child(player)
	enter()
	ready = true

func enter():
	var spawn = get_node(spawn_name)
	player.set_position(spawn.position)

func get_player():
	return player
