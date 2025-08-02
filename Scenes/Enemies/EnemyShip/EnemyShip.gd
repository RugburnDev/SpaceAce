extends EnemyBase

class_name EnemyShip


@onready var laser_timer: Timer = $LaserTimer
@onready var gun_mounts: Node2D = $GunMounts
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@export var _shoots_at_player : bool = false
@export var _aims_at_player : bool = false
@export var _bullet_type : BulletBase.BulletType = BulletBase.BulletType.Enemy
@export var _bullet_speed : float = 120.0
@export var _bullet_direction : Vector2 = Vector2.DOWN
@export var _bullet_wait_time : float = 3.0
@export var _bullet_wait_time_var : float = 0.5
@export var _power_up_chance : float = 0.5


var _player_ref : Player



func _ready() -> void:
	_player_ref = get_tree().get_nodes_in_group(Player.GROUP_NAME).front()
	SpaceUtils.set_and_start_timer(laser_timer, _bullet_wait_time, _bullet_wait_time_var)
	SpaceUtils.play_random_animation(animated_sprite_2d)
	
	if len(gun_mounts.get_children()) == 0:
		push_warning("No gun mount locations set, entity will not shoot.")


func _die() -> void:
	if randf() < _power_up_chance:
		SignalHub.emit_on_create_random_power_up(global_position)
	super()


func _shoot() -> void:
	for gun_location : Marker2D in gun_mounts.get_children():
		if _aims_at_player:
			_bullet_direction = gun_location.global_position.direction_to(_player_ref.global_position).normalized()
		SignalHub.emit_on_create_bullet(gun_location.global_position, _bullet_direction, _bullet_type, _bullet_speed)


func _on_laser_timer_timeout() -> void:
	if _shoots_at_player:
		_shoot()
		SpaceUtils.set_and_start_timer(laser_timer, _bullet_wait_time, _bullet_wait_time_var)
