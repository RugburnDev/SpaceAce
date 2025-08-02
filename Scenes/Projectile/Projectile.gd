extends Area2D


class_name Projectile

@export var _damage : int = 10


func get_damage() -> int:
	return _damage


func blow_up(_area: Area2D) -> void:
	set_process(false)
	queue_free()


func _on_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	blow_up(area)
