extends Node

var current_scene: Node2D = null
var next_scene: Node2D = null
var scene_transition = null

func get_player():
	if current_scene != null:
		return current_scene.get_player()
		
	return null

func set_scene(scene):
	$CanvasLayer.get_node("bg").visible = true
	if current_scene == null:
		current_scene = scene
		add_child(current_scene)
		$AnimationPlayer.play_backwards("bg_fade")
	elif scene.fade == false:
		$CanvasLayer.get_node("bg").visible = false
		if current_scene != null:
			remove_child(current_scene)
		current_scene = scene
		add_child(current_scene)
	else:
		next_scene = scene
		$AnimationPlayer.play("bg_fade")
		scene_transition = true

func _on_animation_finished(anim_name):
	if anim_name == "bg_fade":
		if scene_transition != null:
			if scene_transition:
				if current_scene != null:
					remove_child(current_scene)
				current_scene = next_scene
				next_scene = null
				add_child(current_scene)
				$AnimationPlayer.play_backwards("bg_fade")
				scene_transition = false
			else:
				$CanvasLayer.get_node("bg").visible = false
				scene_transition = null
		else:
			$CanvasLayer.get_node("bg").visible = false
