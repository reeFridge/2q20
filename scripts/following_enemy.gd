extends KinematicBody2D

var enabled = false
export(SpriteFrames) var sprite_frames = null
export(float) var speed = 50
onready var start_position = position

func reset():
	enabled = false
	position = start_position

func _ready():
	$sprite.frames = sprite_frames

func _physics_process(delta):
	if !enabled:
		$sprite.play("stand")
		return

	var target: Vector2 = (Global.get_player().position - position).normalized()
	
	if target.length_squared() != 0:
		$sprite.play("walk")
	else:
		$sprite.play("stand")

	$sprite.set_flip_h(target.x < 0)
	var result = move_and_collide(target * speed * delta)
	if result != null && result.collider == Global.get_player():
		Global.main.current_scene.get_node("change_ep").play()
		call_deferred("reset")
		Global.call_deferred("change_scene", 0)
		match Stats.episode:
			0: Stats.set_deferred("episode", 1)
			1: Stats.set_deferred("episode", 2)
			2: Stats.set_deferred("episode", 3)
