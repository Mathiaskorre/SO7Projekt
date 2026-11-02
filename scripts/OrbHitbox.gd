class_name OrbHitbox
extends Area3D

@export var bounce_val = 10

func _init() -> void:
	collision_layer = 2
	collision_mask = 0
