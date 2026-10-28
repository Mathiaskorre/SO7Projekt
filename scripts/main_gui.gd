extends Container
@onready var main_gui = $"."
@onready var Player = $"../../MainGame/Player"
#region Healthbar (not done)
class Healthbar: 
	var objecttype: Node=Panel.new()
	var ownership: int
	var health: float
	var color: Color
	var length: int
	var height: int
	
	func colorshift():
		if health <= 100:
			print("green")

func _on_game_manger_main_gui_run() -> void:
	var healthbar = Healthbar.new()
	healthbar.objecttype = Panel.new()
	healthbar.height = 10
	healthbar.length = 10
	healthbar.color = Color.PALE_GOLDENROD
	healthbar.health = Player.get_meta("health")
	main_gui.add_child(healthbar)
	
	
	print("test")
	pass # Replace with function body.
#endregion
