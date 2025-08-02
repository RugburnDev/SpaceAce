extends Projectile

class_name PowerUp

enum PowerUpType{Health, Shield}
const SPEED : float = 80.0
var TEXTURES : Dictionary = {
	PowerUpType.Health : preload("res://assets/misc/powerupGreen_bolt.png"),
	PowerUpType.Shield : preload("res://assets/misc/shield_gold.png")
}


@onready var sprite_2d: Sprite2D = $Sprite2D


@export var _power_up_type : PowerUpType = PowerUpType.Health:
	get: 
		return _power_up_type
	set(value): 
		_power_up_type = value


func _ready() -> void:
	_update_texture()
	

func _process(delta: float) -> void:
	position += SPEED * delta * Vector2.DOWN
	

func setup(pos:Vector2, power_up_type:PowerUp.PowerUpType=PowerUp.PowerUpType.Health) -> void:
	position = pos
	_power_up_type = power_up_type


func _update_texture() -> void:
	sprite_2d.texture = TEXTURES.get(_power_up_type)
	

func set_random_type() -> void:
	_power_up_type = PowerUpType.values().pick_random()
