extends Container
@onready var main_gui = $"."
@onready var Player = $"../../MainGame/Player"
#region Healthbar (not done)
@onready var health_bar = ProgressBar.new()
@onready var health_bar_label = Label.new()
@onready var boss_health_bar = ProgressBar.new()
@onready var boss_health_bar_label = Label.new()
func _on_game_manger_main_gui_run() -> void:
	for i in range(1):
		if i == 0: # health bar for the player
			health_bar.show_percentage = false
			health_bar_label.text = str(Player.get_meta("health"))
			health_bar.value = Player.get_meta("health")
			health_bar.max_value = Player.get_meta("Max_Health")
			health_bar.size.x = 300
			health_bar.size.y = 60
			health_bar.position.x = 0
			health_bar.position.y = 432
			health_bar_label.position.y = health_bar.position.y + 10
			health_bar_label.position.x = health_bar.size.x /2
			main_gui.add_child(health_bar)
			main_gui.add_child(health_bar_label)
		else: # health bar for the boss(es)
			print("boss health bar")
		
	

#endregion
