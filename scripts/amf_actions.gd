extends CollisionShape2D

func _ready():
	get_parent().connect("triggered_from_inventory", self, "_on_triggered_from_inventory")

func _on_triggered_from_inventory():
	Global.remove_item(get_parent())
	Stats.update_mental(150)
