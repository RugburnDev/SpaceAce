extends BulletBase

class_name BulletPlayer


func _ready() -> void:
	super()


func _process(delta: float) -> void:
	super(delta)
	

func blow_up(area:Area2D):
	if area is HomingMissile or area is EnemyHitBox:
		super(area)
