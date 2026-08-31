extends Node

var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	print(health)

func _input(event):
	if event.is_action_pressed("my_action"):
		health -= 20 
		print(health)
