extends Node
@onready var Controller = $Control
@onready var StartMenu = $Control/StartMenu
signal MainGuiRun

func _on_start_menu_button_signal(Output: Variant) -> void:
	var Controller_child = Controller.get_child(Output+1)
	if Controller_child != null:
		if Controller_child.visible == true:
			Controller_child.visible = false
		else:
			Controller_child.visible = true
		if Controller_child == Controller.get_child(1):
			$Control/Settings.visible = false
			$"Control/Load save".visible = false
			StartMenu.queue_free()
			Controller_child.visible = true
			MainGuiRun.emit()
	else:
		print("No GUI element is attached")
