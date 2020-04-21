extends Node

var location = preload("res://room_1.tscn").instance()

func _ready():
	add_child(location)
