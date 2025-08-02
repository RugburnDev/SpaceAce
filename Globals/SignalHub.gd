extends Node


signal _on_player_hit(v: int)
signal _on_player_died()
signal _on_health_pickup()
signal _on_score_updated(v: int)
signal _on_create_explosion(position:Vector2, animation_name:String)
signal _on_create_random_power_up(pos:Vector2)
signal _on_create_power_up(pos:Vector2, power_up_type:PowerUp.PowerUpType)
signal _on_create_bullet(pos:Vector2, direction: Vector2, bullet_type:BulletBase.BulletType, speed: float)
signal _on_create_missile(pos:Vector2, speed: float)


func emit_on_player_died() -> void:
	_on_player_died.emit()
	

func emit_on_health_pickup() -> void:
	_on_health_pickup.emit()


func emit_on_player_hit(v: int) -> void:
	_on_player_hit.emit(v)


func emit_on_score_updated(v: int) -> void:
	_on_score_updated.emit(v)


func emit_on_create_explosion(position:Vector2, animation_name:String) -> void:
	if not ["boom", "explode"].has(animation_name):
		push_error("Unknown Animation Name: %s" % animation_name)
	_on_create_explosion.emit(position, animation_name)


func emit_on_create_power_up(pos:Vector2, power_up_type:PowerUp.PowerUpType) -> void:
	_on_create_power_up.emit(pos, power_up_type)


func emit_on_create_random_power_up(pos:Vector2) -> void:
	_on_create_random_power_up.emit(pos)
	

func emit_on_create_bullet(pos:Vector2, direction: Vector2, bullet_type:BulletBase.BulletType, speed: float) -> void:
	_on_create_bullet.emit(pos, direction, bullet_type, speed)


func emit_on_create_missile(pos:Vector2, speed:float=-1) -> void:
	_on_create_missile.emit(pos, speed)
