extends PanelContainer

onready var container = $MarginContainer/HBoxContainer
var items = []
var icons = []

func add_item(item):
	items.push_back(item)
	var icon = preload("res://ui/inventory_item.tscn").instance()
	icon.texture = item.inventory_texture
	icons.push_back(icon)
	container.add_child(icon)
	update_placeholder()
	
func has_item_with_text(text):
	for item in items:
		if item.text == text:
			return true
	
	return false

func update_placeholder():
	if len(items) == 0:
		container.get_node("placeholder").show()
	else:
		container.get_node("placeholder").hide()

func _ready():
	container.get_node("placeholder").show()
