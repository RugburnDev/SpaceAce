extends Projectile

class_name BulletBase

enum BulletType{Player, Enemy, Bomb}

var _direction : Vector2
var _speed : float
var _start_posit : Vector2
var _initialized : bool = false

func _ready() -> void:
	if _initialized:
		global_position = _start_posit
	else:
		push_error("Must call initialize() on Bullets prior to adding to tree.")
		queue_free()


func initialize(start_posit: Vector2, direction : Vector2, speed : float) -> void:
	_start_posit = start_posit
	_direction = direction
	_speed = speed
	_initialized = true


func _process(delta: float) -> void:
	position += delta * _speed * _direction
	

func blow_up(area: Area2D) -> void:
	SignalHub.emit_on_create_explosion(global_position, "explode")
	super(area)
