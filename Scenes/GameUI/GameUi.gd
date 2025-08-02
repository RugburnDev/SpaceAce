extends Control


const HEALTH_POWERUP_STRENGTH : int = 25
const HEALTH_16 = preload("res://assets/sounds/powerup/health_16.wav")


@onready var health_bar: HealthBar = $MarginContainer/HealthBar
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var audio: AudioStreamPlayer = $Audio



func _ready() -> void:
	pass 


func _enter_tree() -> void:
	SignalHub._on_player_hit.connect(_on_player_hit)
	SignalHub._on_score_updated.connect(_on_score_updated)
	SignalHub._on_health_pickup.connect(_on_health_pickup)


func _on_player_hit(v:int) -> void:
	health_bar.take_damage(v)
	
	
func _on_score_updated(_v: int) -> void:
	call_deferred("_update_score")


func _on_health_pickup() -> void:
	audio.stream = HEALTH_16
	audio.play()
	health_bar.increase_value(HEALTH_POWERUP_STRENGTH)

	
func _update_score() -> void:
	score_label.text = "%06d" % ScoreManager.score
	

func _on_health_bar_died() -> void:
	print("PLAYER DIED")
	var player_ref : Player = get_tree().get_nodes_in_group(Player.GROUP_NAME).front()
	player_ref.die()
