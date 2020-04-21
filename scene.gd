extends Node2D

var player = preload("res://player.tscn").instance()

func _ready():
	add_child(player)
	$player.set_position($spawn.position)
	var cam = $cam
	cam.current = true
	remove_child($cam)
	$player.add_child(cam)
	$player.maxBottom = $max_bottom.get_path()
	$player.maxTop = $max_top.get_path()
	$player.maxLeft = $max_left.get_path()
	$player.maxRight = $max_right.get_path()
	pass
