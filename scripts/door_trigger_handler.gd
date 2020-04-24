extends Node

export var scene_index = 0
export var scene_spawn = "spawn"

func _on_triggered():
	Global.change_scene(scene_index, scene_spawn)
