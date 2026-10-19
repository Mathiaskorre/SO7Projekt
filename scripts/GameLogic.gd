extends Node
@onready var Controller = $Control
@onready var StartMenu = $Control/StartMenu

func _on_start_menu_button_signal(Output: Variant) -> void:
	var Controller_child = Controller.get_child(Output+1)
	if Controller_child != null:
		if Controller_child.visible == true:
			Controller_child.visible = false
		else:
			Controller_child.visible = true
	if Controller_child == Controller.get_child(1):
		StartMenu.queue_free()
		Controller_child.visible = true
	else:
		print("No GUI element is attached")
