extends BulletBase

class_name BulletBomb


func _ready() -> void:
	_damage = 15
	super()


func _process(delta: float) -> void:
	super(delta)
