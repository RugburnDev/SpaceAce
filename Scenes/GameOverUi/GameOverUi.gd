extends Control

@onready var score_label: Label = $VBContainer/ScoreLabel
@onready var wait_timer: Timer = $WaitTimer
@onready var main_menu_label: Label = $VBContainer/MainMenuLabel

var _can_shoot :bool = false



func _enter_tree() -> void:
	SignalHub._on_player_died.connect(_on_player_died)


func _on_player_died() -> void:
	update_score()
	show()
	wait_timer.start()
	

func update_score() -> void:
	score_label.text = "Score: %d (Best: %d)" % [ScoreManager.score, ScoreManager.high_score]


func _unhandled_input(event: InputEvent) -> void:
	if _can_shoot and event.is_action_pressed("shoot"):
		GameManager.load_main_scene()
	if event.is_action_pressed("exit"):
		GameManager.load_main_scene()
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused


func _on_wait_timer_timeout() -> void:
	main_menu_label.show()
	_can_shoot = true
	await get_tree().create_timer(0.5).timeout
	var tween : Tween = create_tween()
	tween.tween_property(main_menu_label, "modulate", Color(1,1,1,0.1), 0.5)
	tween.tween_property(main_menu_label, "modulate", Color(1,1,1,1.0), 0.5)
	tween.set_loops()
	tween.play()
