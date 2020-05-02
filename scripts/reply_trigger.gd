extends Area2D

export var text = ""
export var once = true

func _ready():
	connect("body_entered", self, "_on_body_entered")
	
func _on_body_entered(body):
	body.stop()
	Global.show_text(text)
	if once:
		get_parent().call_deferred("remove_child", self)
		call_deferred("queue_free")
