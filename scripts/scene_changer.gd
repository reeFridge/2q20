extends HBoxContainer

func _ready():
	for i in len(Global.scenes):
		var button = Button.new()
		button.connect("pressed", self, "on_pressed", [i])
		button.text = String(i)
		add_child(button)

func on_pressed(i):
	Global.change_scene(i)
	get_parent().hide()
	get_parent().get_node("music").stop()
	Global.game_state = Global.GameState.Play
