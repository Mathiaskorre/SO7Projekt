extends Node3D
@export var nextWaveTime: float = 0.01
@export var maxOrbs :int = 10
@export var orbs: Array[PackedScene]

@onready var main_game = $".."
@onready var timer: Timer = $MobTimer
@onready var collision_shape = $CollisionShape3D

var currentOrbs = 0
var randomGenerator = RandomNumberGenerator.new()

const orbsPerWave: int = 1

func _ready() -> void:
	timer.wait_time = nextWaveTime
	timer.start()

func _on_mob_timer_timeout() -> void:
	if get_tree().current_scene.get_child_count() - 2 < maxOrbs and currentOrbs == maxOrbs:
		currentOrbs -= 1
		timer.start()
	for i in orbsPerWave:
		var OrbsNode=orbs[0].instantiate()
		get_tree().current_scene.add_child(OrbsNode)
		OrbsNode.global_position = _get_random_point()
	currentOrbs += 1
	if currentOrbs == maxOrbs:
		timer.stop()
func _get_random_point():
	var Shape: BoxShape3D = collision_shape.shape
	var halfsize=Shape.size/2
	return collision_shape.global_position + _get_random_point_box_shape(halfsize)
		
func _get_random_point_box_shape(halfsize):
	var xPos = randomGenerator.randf_range(-halfsize.x,halfsize.x) + global_position.x
	var zPos = randomGenerator.randf_range(-halfsize.z,halfsize.z) + global_position.z
	return Vector3(xPos, global_position.y, zPos)
