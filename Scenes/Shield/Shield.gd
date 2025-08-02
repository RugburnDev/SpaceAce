extends Area2D

class_name Shield


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer2D = $Sound


@export var _start_health : int = 5
var _health : int


func _ready() -> void:
	SpaceUtils.toggle_area2d(self, false)
	animation_player.play("RESET")
	
	
func activate_shield() -> void:
	timer.start()
	_health = _start_health
	sound.play()
	if not visible:
		animation_player.play("RESET")
		animation_player.play("activate")
		SpaceUtils.toggle_area2d(self, true)


func deactivate_shield() -> void:
	timer.stop()
	animation_player.play("deactivate")
	SpaceUtils.toggle_area2d(self, false)


func _on_area_entered(_area: Area2D) -> void:
	animation_player.play("hit")
	_health -= 1
	if _health <= 0:
		deactivate_shield()


func _on_timer_timeout() -> void:
	animation_player.play("dying")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "dying":
		deactivate_shield()
