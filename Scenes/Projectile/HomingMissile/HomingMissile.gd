extends Projectile

class_name HomingMissile


@export var POINTS : int = 5

var _speed : float = 100.0
var _rotation_speed : float = 5.0
var _starting_posit : Vector2
var _player_ref : Player
var _initialized : bool = false


func _ready() -> void:
	if _initialized:
		_player_ref = get_tree().get_nodes_in_group(Player.GROUP_NAME).front() 
		global_position = _starting_posit
	else:
		push_error("Must call initialize() on Bullets prior to adding to tree.")
		queue_free()


func initialize(pos:Vector2, speed:float=100.0) -> void:
	_starting_posit = pos
	_speed = speed
	_damage = 25
	_initialized = true


func get_angle_to_player() -> float:
	return transform.x.angle_to(global_position.direction_to(_player_ref.global_position))

	
func blow_up(area: Area2D):
	if area is BulletPlayer:
		ScoreManager.increment_score(POINTS)
	SignalHub.emit_on_create_explosion(global_position, "explode")
	super(area)


func _process(delta: float) -> void:
	if not _player_ref.visible:
		set_process(false)
		blow_up(Area2D.new())
	var homing_input_angle = get_angle_to_player()
	rotate(sign(homing_input_angle) * min(abs(homing_input_angle), _rotation_speed * delta))
		
	position += transform.x.normalized() * _speed * delta
