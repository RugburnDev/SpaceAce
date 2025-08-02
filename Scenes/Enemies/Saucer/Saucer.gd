class_name Saucer
extends EnemyBase


const SAUCER_1 = preload("res://assets/ships/saucer_1.png")
const SAUCER_2 = preload("res://assets/ships/saucer_2.png")
const TEXTURES = [SAUCER_1, SAUCER_2]
const SCI_FI_DOOR = preload("res://assets/sounds/misc/sci-fi-door.wav")

@onready var shoot_timer: Timer = $ShootTimer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite_2d: Sprite2D = $Sprite2D


var _take_shot : bool = false


func _ready() -> void:
	sprite_2d.texture = TEXTURES.pick_random()
	

func _shoot() -> void:
	_take_shot = false
	SignalHub.emit_on_create_missile(global_position)


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	SpaceUtils.set_and_start_timer(shoot_timer, 5.0, 2.0)


func _on_shoot_timer_timeout() -> void:
	_take_shot = true


func play_doors_openning_sound() -> void:
	sound.stream = SCI_FI_DOOR
	sound.play()
