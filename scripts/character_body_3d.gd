extends CharacterBody3D
@onready var player = $"."

var speed = 5.0
var jump_velocity = 4.5


func _physics_process(delta: float) -> void:
	damage_taken(1)
	#player.set_meta("health",200)
	#print(player.get_meta("health"))
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	move_and_slide()

func damage_taken(damage:float) -> void:
	var hp = player.get_meta("health")
	if hp <= 0:
		pass
		#print("You are dead!")
	else:
		player.set_meta("health",hp-damage)
		#print(player.get_meta("health"))
