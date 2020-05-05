extends Node
signal update

const MAX_MENTAL = 100.0

var mental = MAX_MENTAL
var interval = 7 * 1000
var last_update = 0
var episode = 0

func _process(delta):
	if Global.game_state == Global.GameState.Play:
		var diff = OS.get_ticks_msec() - last_update
		if diff > interval:
			update_mental(-1)
			last_update = OS.get_ticks_msec()

func update_mental(diff):
	mental = clamp(mental + diff, 0.0, MAX_MENTAL)
	emit_signal("update")
