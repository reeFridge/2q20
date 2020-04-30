extends Node
signal update

const MAX_MENTAL = 100.0

var mental = MAX_MENTAL
var interval = 1 * 1000
var last_update = 0

func _process(delta):
	var diff = OS.get_ticks_msec() - last_update
	if diff > interval:
		update_mental(-1)
		last_update = OS.get_ticks_msec()

func update_mental(diff):
	mental = clamp(mental + diff, 0.0, MAX_MENTAL)
	emit_signal("update")
