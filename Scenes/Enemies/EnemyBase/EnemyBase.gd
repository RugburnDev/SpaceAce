extends PathFollow2D

class_name EnemyBase

@onready var booms: Node2D = $Booms
@onready var health_bar: HealthBar = $HealthBar
@onready var sound: AudioStreamPlayer2D = $Sound


@export var _crash_damage : int = 10
@export var _points : int = 10

var speed : float = 100.0


func _process(_delta: float) -> void:
	progress += speed * _delta
	_check_progress()
	

func get_damage() -> int:
	return _crash_damage


func _make_booms() -> void:
	for boom in booms.get_children():
		SignalHub.emit_on_create_explosion(boom.global_position, Explosion.BOOM)


func _die() -> void:
	_make_booms()
	ScoreManager.increment_score(_points)
	call_deferred("queue_free")


func _check_progress() -> void:
	if progress_ratio >= .99:
		call_deferred("queue_free")


func _on_health_bar_died() -> void:
	_die()


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area is BulletBase:
		health_bar.take_damage(area.get_damage())
