extends CharacterBody3D
@onready var player = $"."
@onready var camera := $Camer/SpringArm3D/Camera3D as Camera3D
@onready var camera_pivot := $Camer as Node3D 
@onready var spring_arm:= $Camer/SpringArm3D as SpringArm3D
@export var tilt_limit = deg_to_rad(75)
@export var max_spring_length: float = 10
@export var min_spring_length: float = 1
@export_range(0.0,1.0) var mouse_sensitivity = 0.01
var double_jump = false
func _physics_process(delta: float) -> void:
	
	#region Movement
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_pressed("my_action") and is_on_floor():
		velocity.y = player.get_meta("jump_velocity")
		double_jump = true
	elif Input.is_action_just_pressed("my_action") and double_jump == true:
		velocity.y = player.get_meta("jump_velocity")
		double_jump = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("a_action", "d_action", "w_action", "s_action")
	var direction := ((transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()).rotated(Vector3(0,1,0),camera_pivot.rotation.y)
	
	if direction:
		velocity.x = direction.x * player.get_meta("speed")
		velocity.z = direction.z * player.get_meta("speed")
	else:
		velocity.x = move_toward(velocity.x, 0, player.get_meta("speed"))
		velocity.z = move_toward(velocity.z, 0, player.get_meta("speed"))
	move_and_slide()
	#endregion

func _process(_delta: float) -> void:
	if camera_pivot:
		camera.look_at(camera_pivot.global_position, Vector3.UP)

func _input(event: InputEvent) -> void:
	#region Camera control
	if event is InputEventMouseMotion and Input.is_action_pressed("m2_action"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		camera_pivot.rotation.x -= event.screen_relative.y * mouse_sensitivity
		camera_pivot.rotation.x = clampf(camera_pivot.rotation.x, -tilt_limit, tilt_limit)
		camera_pivot.rotation.y -= event.screen_relative.x * mouse_sensitivity
	if Input.is_action_just_released("m2_action"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN):
		if spring_arm.spring_length != max_spring_length:
			spring_arm.spring_length += 1
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP):
		if spring_arm.spring_length != min_spring_length:
			spring_arm.spring_length -= 1
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#endregion

	
func damage_taken(damage:float) -> void:
	var hp = player.get_meta("health")
	if hp <= 0:
		pass
		#print("You are dead!")
	else:
		player.set_meta("health",hp-damage)
		#print(player.get_meta("health"))
