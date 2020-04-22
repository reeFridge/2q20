extends Node

func get_player():
	if get_child_count() > 0:
		return get_child(0).get_player()
		
	return null

func set_scene(scene):
	if get_child_count() > 0:
		remove_child(get_child(0))

	add_child(scene)
