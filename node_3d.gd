extends Node3D
var nextWaveTime: float = 2.5
var orbsPerWave: int = 4
var maxWaves := 2
@onready var enemies: Array[PackedScene]

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
		var randomEnemyNode=enemies.pick_random().instantiate()
		get_tree().current_scene.add_child(randomEnemyNode)
		randomEnemyNode.global_position = _get_random_point()
		'	var mesh_instance = MeshInstance3D.new()
		var sphere_mesh = SphereShape3D.new()
		sphere_mesh.radius = 1.0
		mesh_instance.mesh = sphere_mesh
		mesh_instance.global_position = Vector3(1,1,1)
		main_game.add_child(mesh_instance)'
	
	
	currentWave += 1
	
	if currentWave == maxWaves:
		timer.stop()
func _get_random_point():
	var Shape:BoxShape3D = collision_shape.shape
	var halfsize=Shape.size/2
	return collision_shape.global_position + _get_random_point_box_shape(halfsize)
		
func _get_random_point_box_shape(halfsize):
	var xPos = randomGenerator.randf_range(-halfsize.x,halfsize.x) + global_position.x
	var zPos = randomGenerator.randf_range(-halfsize.z,halfsize.z) + global_position.z
	return Vector3(xPos, global_position.y, zPos)


func _on_timer_timeout() -> void:
	pass # Replace with function body.
