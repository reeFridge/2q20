extends Area2D

export var target_scene = 0
export var target_spawn = "spawn"

func _on_body_entered(body):
	Global.call_deferred("change_scene", target_scene, target_spawn)
