class_name PlayerCollectionbox
extends Area3D


func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	area_entered.connect(
	func _on_area_entered(hit_area: OrbHitbox) -> void:
		if hit_area != null and owner.has_method("bounce"):
			owner.bounce(hit_area.bounce_val)
			#hit_area.get_parent().queue_free()
)
	
