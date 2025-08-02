extends Node2D


const ADD_OBJECT: String = "add_object"

const EXPLOSION = preload("res://Scenes/Explosion/Explosion.tscn")
const POWER_UP = preload("res://Scenes/Projectile/PowerUp/PowerUp.tscn")
const BULLET_BOMB = preload("res://Scenes/Projectile/Bullets/BulletBomb/BulletBomb.tscn")
const BULLET_ENEMY = preload("res://Scenes/Projectile/Bullets/BulletEnemy/BulletEnemy.tscn")
const BULLET_PLAYER = preload("res://Scenes/Projectile/Bullets/BulletPlayer/BulletPlayer.tscn")
const HOMING_MISSILE = preload("res://Scenes/Projectile/HomingMissile/HomingMissile.tscn")


func _ready() -> void:
	SignalHub._on_create_explosion.connect(_on_create_explosion)
	SignalHub._on_create_power_up.connect(_on_create_power_up)
	SignalHub._on_create_random_power_up.connect(_on_create_random_power_up)
	SignalHub._on_create_bullet.connect(_on_create_bullet)
	SignalHub._on_create_missile.connect(_on_create_missile)


func add_object(obj:Node, pos:Vector2) -> void:
	add_child(obj)
	obj.global_position = pos


func _on_create_missile(pos:Vector2, speed: float):
	var missile : HomingMissile = HOMING_MISSILE.instantiate()
	if speed > 0:
		missile.initialize(pos, speed)
	else:
		missile.initialize(pos)
	call_deferred(ADD_OBJECT, missile, pos)
	

func _on_create_bullet(pos:Vector2, direction: Vector2, bullet_type:BulletBase.BulletType, speed: float):
	var bullet : BulletBase
	match bullet_type:
		BulletBase.BulletType.Bomb:
			bullet = BULLET_BOMB.instantiate()
		BulletBase.BulletType.Player:
			bullet = BULLET_PLAYER.instantiate()
		BulletBase.BulletType.Enemy:
			bullet = BULLET_ENEMY.instantiate()
			
	bullet.initialize(pos, direction, speed)
	call_deferred(ADD_OBJECT, bullet, pos)


func _on_create_explosion(pos:Vector2, animation_name:String):
	var explosion : Explosion = EXPLOSION.instantiate()
	explosion.setup(pos, animation_name)
	call_deferred(ADD_OBJECT, explosion, pos)


func _on_create_power_up(pos:Vector2, power_up_type:PowerUp.PowerUpType):
	var power_up : PowerUp = POWER_UP.instantiate()
	power_up.setup(pos, power_up_type)
	call_deferred(ADD_OBJECT, power_up, pos)


func _on_create_random_power_up(pos:Vector2):
	var power_up : PowerUp = POWER_UP.instantiate()
	power_up.setup(pos)
	power_up.set_random_type()
	call_deferred(ADD_OBJECT, power_up, pos)
