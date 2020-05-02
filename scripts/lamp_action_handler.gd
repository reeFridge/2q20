extends AnimatedSprite

func _on_Area2D_triggered():
	get_parent().show_actions_menu({
		toggle = [self, "_on_toggle_action"]
	})

func _on_toggle_action(action):
	if is_playing():
		stop()
		hide()
	else:
		show()
		play()
	get_parent().close_actions_menu()
