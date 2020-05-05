extends Node

export(Array, String) var text = []
export var interval = 10
export var once = true
export var bbcode = false
export var episode_mask = 0

func _ready():
	get_parent().connect("entered", self, "reply")

func reply():
	if Stats.episode == episode_mask:
		var player = Global.get_player()
		player.stop()
		player.enabled = false
		Global.main.get_node("ui").connect("text_queue_free", self, "on_replies_finished")
		Global.show_text_series(text, interval, bbcode)

func on_replies_finished():
	Global.get_player().enabled = true
	if once:
		get_parent().remove_child(self)
		queue_free()
