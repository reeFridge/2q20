extends Control

onready var inventory_container = $inventory/MarginContainer/HBoxContainer
onready var desc_name = $desc/MarginContainer/VBoxContainer/name
onready var desc_text = $desc/MarginContainer/VBoxContainer/desc
var items = []
var icons = []

var take_sound = preload("res://assets/sounds/flap.ogg")

func update_active_state(item, state):
	var item_idx = items.find(item)
	if item_idx != -1:
		var icon = icons[item_idx]
		icon.get_node("container").visible = state

func add_item(item):
	var stream = take_sound
	stream.loop = false
	$audio.stream = stream
	$audio.play()
	items.push_back(item)
	var icon = preload("res://ui/inventory_item.tscn").instance()
	icon.connect("gui_input", self, "item_icon_input", [item])
	icon.connect("mouse_entered", self, "item_icon_focused", [item])
	icon.connect("mouse_exited", self, "item_icon_unfocused")
	icon.texture = item.inventory_texture
	icons.push_back(icon)
	inventory_container.add_child_below_node(inventory_container.get_node("placeholder"), icon)
	update_placeholder()

func remove_item(item):
	var item_idx = items.find(item)
	if item_idx != -1:
		var icon = icons[item_idx]
		item_icon_unfocused()
		inventory_container.remove_child(icon)
		items.remove(item_idx)
		icons.remove(item_idx)
	update_placeholder()
	
func has_item(item_text):
	for i in items:
		if i.text == item_text:
			return true
			
	return false

func item_icon_focused(item):
	$desc.show()
	desc_name.text = item.text
	desc_text.text = item.inventory_text
	
func item_icon_unfocused():
	$desc.hide()
	desc_name.text = ""
	desc_text.text = ""
	# force update size
	$desc.show()
	$desc.hide()

func update_placeholder():
	if len(items) == 0:
		inventory_container.get_node("placeholder").show()
	else:
		inventory_container.get_node("placeholder").hide()
	# force update size
	$inventory.grow_horizontal = Control.GROW_DIRECTION_BEGIN

func item_icon_input(event, item):
	if event is InputEventMouseButton && event.pressed:
		item.activated_from_inventory()

func _ready():
	inventory_container.get_node("placeholder").show()
