extends KinematicBody2D

export var maxTop: NodePath
export var maxBottom: NodePath
export var maxLeft: NodePath
export var maxRight: NodePath

export var speed = 100

var direction = Vector2()

func _physics_process(delta):
	var pressedX = false
	var pressedY = false
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
		$AnimatedSprite.flip_h = false
		pressedX = true
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		$AnimatedSprite.flip_h = true
		pressedX = true
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
		pressedY = true
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
		pressedY = true

	if !pressedX:
		direction.x = 0
	if !pressedY:
		direction.y = 0

	if pressedX || pressedY:
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("stand")
	
	# speed is constant whenever move is either straight by axis or by diagonal
	var velocity = direction.normalized() * speed
	move_and_slide(velocity)
	
	var maxTopY = get_node(maxTop).global_position.y;
	var maxBottomY = get_node(maxBottom).global_position.y
	var maxRightX = get_node(maxRight).global_position.x
	var maxLeftX = get_node(maxLeft).global_position.x
	
	if (global_position.y <= maxTopY):
		global_position.y = maxTopY + 1
	if (global_position.y >= maxBottomY):
		global_position.y = maxBottomY - 1
	if (global_position.x <= maxLeftX):
		global_position.x = maxLeftX + 1
	if (global_position.x >= maxRightX):
		global_position.x = maxRightX - 1
	
