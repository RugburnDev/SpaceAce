extends Area2D

class_name EnemyHitBox


@onready var enemy_base: EnemyBase = $".."


func get_damage() -> int:
	return enemy_base.get_damage()
