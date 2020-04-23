extends Node

var current_scene: Node2D = null
var next_scene: Node2D = null

enum TransitionPhase {
	NONE,
	FADE_IN,
	FADE_OUT
}

var scene_transition_phase = TransitionPhase.NONE

func _ready():
	$ui.show_fading_rect()

func get_player():
	if current_scene != null:
		return current_scene.get_player()
		
	return null

func set_scene(scene):
	if current_scene == null:
		next_scene = scene
		next_transition_phase(TransitionPhase.FADE_IN)
		pass

	if scene.fade:
		next_scene = scene
		next_transition_phase()
	else:
		$ui.hide_fading_rect()
		next_scene = scene
		perform_transition()

func perform_transition():
	if current_scene != null:
		remove_child(current_scene)
	current_scene = next_scene
	next_scene = null
	add_child(current_scene)
	
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
