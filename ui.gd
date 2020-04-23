extends CanvasLayer

func _ready():
	pass

func _on_animation_finished(anim_name):
	if (anim_name == "bg_fade"):
#		$bg.visible = false
		pass


func _on_animation_started(anim_name):
	if (anim_name == "bg_fade"):
#		$bg.visible = true
		pass
