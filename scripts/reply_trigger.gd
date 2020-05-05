extends Area2D

export var text = ""
export(Array, String) var texts = []
export var once = true
export var episode_mask = 0

func _ready():
	connect("body_entered", self, "_on_body_entered")
	
func _on_body_entered(body):
	if Stats.episode == episode_mask:
		body.stop()
		if texts.empty():
			Global.show_text(text)
		else:
			Global.show_text_series(texts)
		if once:
			get_parent().call_deferred("remove_child", self)
			call_deferred("queue_free")
