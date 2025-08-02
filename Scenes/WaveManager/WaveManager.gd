extends Node2D

const WAVES = preload("res://Resources/Waves.tres")

@onready var paths: Node2D = $Paths
@onready var spawn_timer: Timer = $SpawnTimer

var _wave_count : int = 0
var _wave_gap : float = 4.0
var _speed_factor : float = 1.0
var _path_list : Array[Path2D]


func _ready() -> void:
	for path : Node2D in paths.get_children():
		_path_list.push_back(path)
	spawn_timer.wait_time = _wave_gap
	spawn_timer.start()
	

func _spawn_wave() -> void:
	var path : Path2D = _path_list.pick_random()
	var wave : EnemyWave = WAVES.get_wave_for_wave_count(_wave_count)
	for i in range(wave.number):
		if i > 0:
			await get_tree().create_timer(wave.gap).timeout
		var enemy : EnemyBase = wave.enemy_scene.instantiate()
		enemy.speed = wave.speed * _speed_factor
		path.add_child(enemy)
	_wave_count += 1


func _on_spawn_timer_timeout() -> void:
	_spawn_wave()
	if _wave_count > 0 and _path_list.size() % _wave_count == 0:
		_wave_gap -= 0.2
		_wave_gap = max(_wave_gap, 1.0)
		spawn_timer.wait_time = _wave_gap
	spawn_timer.start()
