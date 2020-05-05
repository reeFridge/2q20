extends Node

func enter():
	Global.get_player().enabled = false

func before_enter():
	get_parent().get_node("blinking").stop()
	var enemy = get_parent().get_node_or_null("container/enemy")
	var enemy2 = get_parent().get_node_or_null("container/enemy2")
	if enemy && enemy.start_position:
		enemy.reset()
	if enemy2 && enemy2.start_position:
		enemy2.reset()

	var ui = Global.main.get_node("ui")
	if !ui.is_connected("text_shown", self, "on_text_shown"):
		ui.connect("text_shown", self, "on_text_shown")
	if !ui.is_connected("text_queue_free", self, "on_replies_finished"):
		ui.connect("text_queue_free", self, "on_replies_finished")

func on_text_shown(text: String):
	match Stats.episode:
		0:
			if text.match("*THE ONLY FUCKING SICK HERE*"):
				Global.get_player().get_node("AnimatedSprite").play("squatting")
			elif text.match("*whatever we want*"):
				Global.get_player().get_node("AnimatedSprite").play("squatting", true)
			elif text.match("*Stop wasting time*"):
				get_parent().get_node("blinking").play("blink")
				Stats.update_mental(-20)
		1:
			if text.match("*take off the skirt*"):
				Global.get_player().get_node("AnimatedSprite").play("squatting")
			elif text.match("*YOU WANTED IT*"):
				Global.get_player().get_node("AnimatedSprite").play("squatting", true)
				get_parent().get_node("blinking").play("blink")
				Stats.update_mental(-20)
		2:
			if text.match("*STAY AWAY*"):
				Global.get_player().equip_knife(true)
				Global.get_player().get_node("AnimatedSprite").play("attack")
				get_parent().get_node("blinking").play("blink")

func on_replies_finished():
	Global.get_player().enabled = true
	get_parent().get_node("container/enemy").enabled = true
	get_parent().get_node("container/enemy2").enabled = true
