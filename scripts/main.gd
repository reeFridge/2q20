extends Node

var current_scene: Node2D = null
var next_scene: Node2D = null
var player = preload("res://player/player.tscn").instance()

enum TransitionPhase {
	NONE,
	FADE_IN,
	FADE_OUT
}

var scene_transition_phase = TransitionPhase.NONE

func _ready():
	$ui.show_fading_rect()

func get_player():
	return player
	
func glitch():
	$audio.play()
	var variant = rand_range(0.0, 1.0)
	if variant > 0.5:
		$screen_effects.play("glitch")
	else:
		$screen_effects.play_backwards("glitch")

func set_scene(scene, spawn_name):
	scene_transition_phase = TransitionPhase.NONE
	glitch()

	scene.spawn_name = spawn_name
	$ui.text_timeout()

	if current_scene == null:
		next_scene = scene
		next_transition_phase(TransitionPhase.FADE_IN)
		return

	if scene.fade:
		next_scene = scene
		next_transition_phase()
	else:
		$ui.hide_fading_rect()
		next_scene = scene
		perform_transition()

func perform_transition():
	if current_scene != null:
		current_scene.leave()
		remove_child(current_scene)
	add_child(next_scene)
	next_scene.call_deferred("enter", player)
	current_scene = next_scene
	next_scene = null

func next_transition_phase(current_phase = scene_transition_phase):
	match current_phase:
		TransitionPhase.NONE:
			$ui.show_fading_rect()
			$AnimationPlayer.play("fg_fade")
			scene_transition_phase = TransitionPhase.FADE_IN
		TransitionPhase.FADE_IN:
			perform_transition()
			$AnimationPlayer.play_backwards("fg_fade")
			scene_transition_phase = TransitionPhase.FADE_OUT
		TransitionPhase.FADE_OUT:
			$ui.hide_fading_rect()
			scene_transition_phase = TransitionPhase.NONE

func _on_animation_finished(anim_name):
	if anim_name == "fg_fade":
		if scene_transition_phase == TransitionPhase.NONE:
			$ui.hide_fading_rect()
		else:
			next_transition_phase()
