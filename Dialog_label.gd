extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var player = get_node("/root/Node2D/player")
	var new_vector = player.get_position()
	new_vector.x = new_vector.x + 20
	new_vector.y = new_vector.y - 80
	set_position(new_vector)

