extends CanvasLayer

var text_timer: Timer = null

func hide_fading_rect():
	$fg.visible = false
	
func show_fading_rect():
	$fg.visible = true
	
func show_text(text, timeout):
	remove_text_timer()
	get_parent().get_node("AnimationPlayer").stop()
	get_parent().get_node("AnimationPlayer").play("typing")
	$text_panel.visible = true
	$text_panel/text.text = text
	var timer = Timer.new()
	timer.connect("timeout", self, "text_timeout")
	timer.one_shot = true
	timer.wait_time = timeout
	timer.autostart = true
	add_child(timer)
	text_timer = timer
	
func remove_text_timer():
	if text_timer != null:
		text_timer.stop()
		remove_child(text_timer)
		text_timer.queue_free()
		text_timer = null
	
func text_timeout():
	remove_text_timer()
	hide_text()

func hide_text():
	$text_panel.visible = false
