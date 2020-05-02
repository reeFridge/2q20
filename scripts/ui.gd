extends CanvasLayer

var text_timer: Timer = null

func _ready():
	$mental.max_value = Stats.MAX_MENTAL
	update_mental()
	Stats.connect("update", self, "update_mental")

func hide_fading_rect():
	$fg.visible = false
	
func show_fading_rect():
	$fg.visible = true
	
func update_mental():
	$mental.value = Stats.mental

func show_text(text, timeout):
	$overlay.show()
	remove_text_timer()
	$text_panel/anim.stop()
	$text_panel/anim.play("typing")
	$text_panel.visible = true
	$text_panel/text.text = text
	var timer = Timer.new()
	timer.connect("timeout", self, "text_timeout")
	timer.one_shot = true
	timer.wait_time = timeout
	timer.autostart = true
	add_child(timer)
	text_timer = timer
	return timer

var text_queue = []
var series_timeout = 10

# series - string[]
# timeout - number
func show_text_series(series, timeout):
	text_queue = series
	series_timeout = timeout
	show_text_from_queue()

func show_text_from_queue():
	show_text(text_queue.pop_front(), series_timeout)

func remove_text_timer():
	if text_timer != null:
		text_timer.stop()
		remove_child(text_timer)
		text_timer.queue_free()
		text_timer = null
	
func text_timeout():
	remove_text_timer()
	hide_text()
	if !text_queue.empty():
		show_text_from_queue()
	else:
		$overlay.hide()

func hide_text():
	$text_panel/text.percent_visible = 0
	$text_panel/text.text = ""
	$text_panel.visible = false

func _on_overlay_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if $text_panel/anim.is_playing():
			$text_panel/anim.stop()
			$text_panel/text.percent_visible = 1
		else:
			text_timeout()
