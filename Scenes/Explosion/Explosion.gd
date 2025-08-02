extends Node2D

class_name Explosion

const BOOM : String = "boom"
const EXPLODE : String = "explode"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var _animation_name : String = EXPLODE
var _position : Vector2 = Vector2.ZERO


func _ready() -> void:
	position = _position
	animated_sprite_2d.animation = _animation_name
	animated_sprite_2d.play()
	

func setup(pos:Vector2, animation_name:String) -> void:
	_position = pos
	_animation_name = animation_name


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
