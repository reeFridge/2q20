extends Area2D

export var target_scene = 0
export var target_spawn = "spawn"
export(Array, int) var episode_masks = []

func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")

func _on_body_entered(body):
	if episode_masks.empty() || Stats.episode in episode_masks:
		Global.call_deferred("change_scene", target_scene, target_spawn)

func _on_mouse_entered():
	if episode_masks.empty() || Stats.episode in episode_masks:
		$Light2D.show()
	
func _on_mouse_exited():
	if episode_masks.empty() || Stats.episode in episode_masks:
		$Light2D.hide()
