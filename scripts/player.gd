extends KinematicBody2D
signal near_target
signal target_changed

export var maxTop: NodePath
export var maxBottom: NodePath
export var maxLeft: NodePath
export var maxRight: NodePath

const MIN_DISTANCE = 10

export var speed = 120

var current_target = null
var min_distance_to_target = MIN_DISTANCE
var direction = Vector2()
var enabled = true
var is_player = true
var knife_equiped = false
var is_attacking = false

var walk_animation = "walk"
var stand_animation = "stand"

func set_collision(state):
	$CollisionShape2D.disabled = !state

func equip_knife(state):
	knife_equiped = state
	if state:
		walk_animation = "knife_walk"
		stand_animation = "knife_stand"
	else:
		walk_animation = "walk"
		stand_animation = "stand"

func change_target(target):
	current_target = target
	emit_signal("target_changed")

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed() and enabled:
		if event.button_index == BUTTON_LEFT:
			var target = get_global_mouse_position()
			if is_vector_inside_zone(target):
				change_target(target)
		elif event.button_index == BUTTON_RIGHT && knife_equiped:
			attack()
			
func attack():
#	is_attacking = true
#	$AnimatedSprite.play("attack")
	pass

func stop():
	$AnimatedSprite.play(stand_animation)
	min_distance_to_target = MIN_DISTANCE
	direction = Vector2()
	change_target(null)
	
func is_vector_inside_zone(vec):
	var maxTopY = get_node(maxTop).global_position.y;
	var maxBottomY = get_node(maxBottom).global_position.y
	var maxRightX = get_node(maxRight).global_position.x
	var maxLeftX = get_node(maxLeft).global_position.x
	
	return vec.y > maxTopY and vec.y < maxBottomY and vec.x > maxLeftX and vec.x < maxRightX
	
func update_facing():
	if direction.x > 0:
		$AnimatedSprite.flip_h = false
	elif direction.x < 0:
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	if !enabled:
		return

	if current_target != null:
		direction = (current_target - global_position).normalized()
		var distance = global_position.distance_to(current_target)
		if min_distance_to_target < 0 || distance < min_distance_to_target:
			emit_signal("near_target")
			update_facing()
			stop()

	var pressedX = false
	var pressedY = false
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
		pressedX = true
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		pressedX = true
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
		pressedY = true
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
		pressedY = true
	
	if pressedX || pressedY:
		change_target(null)

	update_facing()

	if current_target == null:
		if !pressedX:
			direction.x = 0
		if !pressedY:
			direction.y = 0

	if direction.length_squared() && !is_attacking:
		$AnimatedSprite.play(walk_animation)
	else:
		$AnimatedSprite.play(stand_animation)
		
	if !is_inside_tree():
		return

	# speed is constant whenever move is either straight by axis or by diagonal
	var velocity = direction.normalized() * speed
	move_and_slide(velocity)

	var maxTopY = get_node(maxTop).global_position.y;
	var maxBottomY = get_node(maxBottom).global_position.y
	var maxRightX = get_node(maxRight).global_position.x
	var maxLeftX = get_node(maxLeft).global_position.x

	if (global_position.y <= maxTopY):
		stop()
		global_position.y = maxTopY + 1
	if (global_position.y >= maxBottomY):
		stop()
		global_position.y = maxBottomY - 1
	if (global_position.x <= maxLeftX):
		stop()
		global_position.x = maxLeftX + 1
	if (global_position.x >= maxRightX):
		stop()
		global_position.x = maxRightX - 1

