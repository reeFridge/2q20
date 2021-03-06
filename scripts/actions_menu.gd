extends PanelContainer

func _ready():
	set_as_toplevel(true)

func init(actions_map):
	for action in actions_map:
		var button = preload("res://ui/actions_menu_button.tscn").instance()
		button.text = action
		var target = actions_map[action][0]
		var method = actions_map[action][1]
		button.connect("button_down", target, method, [action])
		$MarginContainer/HBoxContainer.add_child(button)

