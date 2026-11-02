extends Node3D
@export var nextWaveTime: float = 0.1
@export var orbsPerWave: int = 1
@export var maxWaves := 4
@export var orbs: Array[PackedScene]

@onready var main_game = $".."
@onready var timer: Timer = $MobTimer
@onready var collision_shape = $CollisionShape3D

var currentWave = 0
var randomGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	timer.wait_time = nextWaveTime
	timer.start()

func _on_mob_timer_timeout() -> void:
	for i in orbsPerWave:
		var randomOrbsNode=orbs.pick_random().instantiate()
		get_tree().current_scene.add_child(randomOrbsNode)
		randomOrbsNode.global_position = _get_random_point()
	currentWave += 1
	if currentWave == maxWaves:
		timer.stop()
func _get_random_point():
	var Shape: BoxShape3D = collision_shape.shape
	var halfsize=Shape.size/2
	return collision_shape.global_position + _get_random_point_box_shape(halfsize)
		
func _get_random_point_box_shape(halfsize):
	var xPos = randomGenerator.randf_range(-halfsize.x,halfsize.x) + global_position.x
	var zPos = randomGenerator.randf_range(-halfsize.z,halfsize.z) + global_position.z
	return Vector3(xPos, global_position.y, zPos)
