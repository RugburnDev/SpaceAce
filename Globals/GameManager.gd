extends Node


const MAIN = preload("res://Scenes/Main/Main.tscn")
const LEVEL = preload("res://Scenes/Level/Level.tscn")


#region input_handling
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test_key"):
		print("TEST KEY PRESSED")
		SignalHub.emit_on_create_missile(Vector2(0,0))
		SignalHub.emit_on_create_power_up(Vector2(300,300),PowerUp.PowerUpType.Health)
		SignalHub.emit_on_create_bullet(Vector2(300,300), Vector2.DOWN, BulletBase.BulletType.Enemy, 100)
#endregion

#region navigation
func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)


func load_level_scene() -> void:
	get_tree().change_scene_to_packed(LEVEL)
#endregion
