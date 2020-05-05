extends CanvasLayer
signal text_shown(text)
signal text_queue_free

const START_SCENE_IDX = 0

var vote_sound = preload("res://assets/sounds/vote.ogg")

var text_timer: Timer = null

func _unhandled_key_input(event):
	if event.pressed and event.scancode == KEY_ESCAPE and Global.game_state != Global.GameState.None:
		if Global.game_state == Global.GameState.Play:
			Global.game_state = Global.GameState.Pause
			pause_resume_timer(true)
			$menu/music.play()
			$menu.show()
			var audio = get_parent().current_scene.get_node_or_null("audio")
			if audio != null:
				audio.stop()
		else:
			pause_resume_timer(false)
			$menu.hide()
			$menu/music.stop()
			var audio = get_parent().current_scene.get_node_or_null("audio")
			if audio != null:
				audio.play()
			Global.game_state = Global.GameState.Play

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

func show_text(text, timeout, bbcode = false):
	var stream: AudioStreamOGGVorbis = vote_sound
	stream.loop = false
	$text_panel/vote.stream = stream
	$text_panel/vote.play()
	$overlay.show()
	remove_text_timer()
	$text_panel/anim.stop()
	$text_panel/anim.play("typing")
	$text_panel.visible = true
	if bbcode:
		$text_panel/text.bbcode_enabled = true
		$text_panel/text.bbcode_text = text
	else:
		$text_panel/text.bbcode_enabled = false
		$text_panel/text.text = text
		
	emit_signal("text_shown", text)

	var timer = Timer.new()
	timer.connect("timeout", self, "text_timeout", [bbcode])
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
func show_text_series(series, timeout, bbcode = false):
	text_queue = series
	series_timeout = timeout
	show_text_from_queue(bbcode)

func show_text_from_queue(bbcode):
	show_text(text_queue.pop_front(), series_timeout, bbcode)

func remove_text_timer():
	if text_timer != null:
		text_timer.stop()
		remove_child(text_timer)
		text_timer.queue_free()
		text_timer = null
		
func pause_resume_timer(state):
	if text_timer != null:
		text_timer.paused = state

func text_timeout(bbcode):
	remove_text_timer()
	hide_text()
	if !text_queue.empty():
		show_text_from_queue(bbcode)
	else:
		emit_signal("text_queue_free")
		$overlay.hide()

func hide_text():
	$text_panel/text.percent_visible = 0
	$text_panel/text.bbcode_enabled = false
	$text_panel/text.bbcode_text = ""
	$text_panel/text.text = ""
	$text_panel.visible = false

func _on_overlay_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if $text_panel/anim.is_playing():
			$text_panel/anim.stop()
			$text_panel/text.percent_visible = 1
		else:
			text_timeout($text_panel/text.bbcode_enabled)

func _on_start_pressed():
	$menu.hide()
	$menu/music.stop()
	$menu/buttons/start.text = "continue"
	if Global.game_state == Global.GameState.None:
		Global.change_scene(START_SCENE_IDX)
	Global.game_state = Global.GameState.Play

func _on_about_pressed():
	$menu/buttons.hide()
	$menu/about.show()

func _on_quit_pressed():
	get_tree().quit(0)

func _on_back_pressed():
	$menu/buttons.show()
	$menu/about.hide()

func _on_about_meta_clicked(meta):
	OS.shell_open(meta)
