extends Node2D
signal entered
signal leaved

var player = null
var spawn_name = "spawn"
var entered_timer = null
export var player_container = ""
export var fade = false
onready var cam = $cam

func enter(player_instance):
	player = player_instance
	cam.current = true
	remove_child(cam)
	player.add_child(cam)
	player.maxBottom = $max_bottom.get_path()
	player.maxTop = $max_top.get_path()
	player.maxLeft = $max_left.get_path()
	player.maxRight = $max_right.get_path()
	var spawn = get_node(spawn_name)
	var direction = spawn.get_node_or_null("direction")
	player.set_position(spawn.position)
	player.stop()
	
	if player_container.empty():
		add_child(player)
	else:
		get_node(player_container).add_child(player)
	
	if direction != null:
		player.change_target(direction.global_position)
		player.min_distance_to_target = -1

	var timer = Timer.new()
	timer.connect("timeout", self, "enter_timeout")
	timer.one_shot = true
	timer.wait_time = 0.5
	timer.autostart = true
	add_child(timer)
	entered_timer = timer
	
func remove_timer():
	if entered_timer != null:
		entered_timer.stop()
		remove_child(entered_timer)
		entered_timer.queue_free()
		entered_timer = null
	
func enter_timeout():
	remove_timer()
	player.set_collision(true)
	emit_signal("entered")
	
func leave():
	player.remove_child(cam)
	if player_container.empty():
		remove_child(player)
	else:
		get_node(player_container).remove_child(player)
	player.set_collision(false)
	player = null
	add_child(cam)
	cam.current = false
	
	emit_signal("leaved")

func get_player():
	return player

func _on_triggered():
	pass # Replace with function body.
