extends VBoxContainer
@onready var container = $"."
signal button_signal(Output)
var button_names = {1:"Start",2:"Load save",3:"Settings",4:"Quit"}
func emitter(i):
	button_signal.emit(i)
	print(i)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(len(button_names)):
		var button = Button.new()
		button.size.x=140
		button.size.y=60
		button.position.y =-140
		button.text = button_names[i+1]
		button.size_flags_horizontal = container.SIZE_SHRINK_CENTER
		button.size_flags_vertical = container.SIZE_FILL
		button.custom_minimum_size.x = 140
		button.custom_minimum_size.y = 20
		container.add_child(button)
		button.pressed.connect(emitter.bind(i))
