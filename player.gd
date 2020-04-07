extends KinematicBody2D

const speed = 150

var velocity = Vector2()

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed 
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
		
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	else:
		velocity.x = 0
		$AnimatedSprite.play("stand")
		
	move_and_slide(velocity)
	
