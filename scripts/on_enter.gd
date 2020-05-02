extends Node

export(Array, String) var text = []
export var interval = 10
export var once = true

func _ready():
	get_parent().connect("entered", self, "reply")
	pass
	
func reply():
	Global.show_text_series(text, interval)
	if once:
		get_parent().remove_child(self)
		queue_free()
