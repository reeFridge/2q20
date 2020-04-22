extends Node

export var scene_index = 0

func _on_triggered():
	Global.change_scene(scene_index)
