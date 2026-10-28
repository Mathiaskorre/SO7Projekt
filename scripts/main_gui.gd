extends Container
@onready var Player = $"../../MainGame/Player"

class Healthbar: #(NOT DONE)
	var objecttype: Object
	var ownership: int
	var health: float
	var color: Color
	var length: Vector2
	var height: Vector2
	
	func colorshift():
		if health <= 100:
			print("green")

func _on_game_manger_main_gui_run() -> void:
	for i in range(1):
		var healthbar = Healthbar.new()
		healthbar.height = 10
	print("test")
	pass # Replace with function body.
