extends KinematicBody2D
signal timer_end


const speed = 150

var velocity = Vector2()

var text = ["Hello ", "there!", " How'dy?"]


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
	


func _on_Dialog_body_entered(body):
	var lab = get_node("/root/Node2D/Dialog_label")
	for i in range(0,text.size()):
		var t = Timer.new()
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		lab.set_text(text[i])
		t.queue_free()
	



