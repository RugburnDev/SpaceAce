extends Area2D


class_name Player


const GROUP_NAME: String = "Player"
const SPEED: float = 250.0
const BULLET_SPEED : float = 300.0
const MARGIN : float = 25.0

@onready var shoot_timer: Timer = $ShootTimer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shield: Shield = $Shield
@onready var gun_mount_l: Marker2D = $GunMount_L
@onready var gun_mount_r: Marker2D = $GunMount_R
@onready var sound: AudioStreamPlayer2D = $Sound


var _direction : Vector2 = Vector2.ZERO
var _can_shoot : bool = true

var screen_bounds : Rect2



func _ready() -> void:
	screen_bounds =  get_viewport().get_visible_rect()


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


func die() -> void:
	SignalHub.emit_on_player_died()
	set_process(false)
	SignalHub.emit_on_create_explosion(global_position, "boom")
	hide()
	SpaceUtils.toggle_area2d(self, false)


func _shoot() -> void:
	if _can_shoot:
		_can_shoot = false
		shoot_timer.start()
		SignalHub.emit_on_create_bullet(gun_mount_l.global_position, Vector2.UP, BulletBase.BulletType.Player,BULLET_SPEED)
		SignalHub.emit_on_create_bullet(gun_mount_r.global_position, Vector2.UP, BulletBase.BulletType.Player,BULLET_SPEED)


func _get_input() -> void:
	_direction = Vector2.ZERO
	if Input.is_action_pressed("left"):
		_direction += Vector2.LEFT
	if Input.is_action_pressed("right"):
		_direction += Vector2.RIGHT
	if Input.is_action_pressed("up"):
		_direction += Vector2.UP
	if Input.is_action_pressed("down"):
		_direction += Vector2.DOWN
	if Input.is_action_pressed("shoot"):
		_shoot()


func _process(delta: float) -> void:
	_get_input()
	if _direction != Vector2.ZERO:
		position += delta * SPEED * _direction.normalized()
		position = Vector2(
			clampf(position.x, screen_bounds.position.x+MARGIN, screen_bounds.end.x-MARGIN),
			clampf(position.y, screen_bounds.position.y+MARGIN, screen_bounds.end.y-MARGIN),
			)


func _on_shoot_timer_timeout() -> void:
	_can_shoot = true


func _on_area_entered(area: Area2D) -> void:
	if area is PowerUp:
		match area._power_up_type:
			PowerUp.PowerUpType.Shield:
				shield.activate_shield()
			PowerUp.PowerUpType.Health:
				SignalHub.emit_on_health_pickup()
	elif area is Projectile:
		SignalHub.emit_on_player_hit(area.get_damage())
	elif area is EnemyHitBox:
		SignalHub.emit_on_player_hit(area.get_damage())
		sound.play()
		
	
