extends Node

export var episode_mask = 2

# only for street/park/graveyard on ep2
func enter():
	if Stats.episode == episode_mask:
		$anim.play("walk")

func before_enter():
	var ui = Global.main.get_node("ui")
	if !ui.is_connected("text_shown", self, "on_text_shown"):
		ui.connect("text_shown", self, "on_text_shown")
		
	if !ui.is_connected("text_queue_free", self, "on_replies_finished"):
		ui.connect("text_queue_free", self, "on_replies_finished")
	
func on_text_shown(text: String):
	if Stats.episode != episode_mask:
		return
	
	Global.get_player().enabled = false
	if text.match("*SHIT*"):
		get_parent().get_node("thing/anim").play("walk")
	elif text.match("*headache*"):
		Global.main.glitch()
		Stats.update_mental(-10)

func on_replies_finished():
	Global.get_player().enabled = true
