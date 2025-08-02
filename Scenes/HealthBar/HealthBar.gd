extends TextureProgressBar

class_name HealthBar

signal died


const COLOR_DANGER: Color = Color("#cc0000")
const COLOR_MIDDLE: Color = Color("#ff9900")
const COLOR_GOOD: Color = Color("#33cc33")


@export var level_low: int = 30
@export var level_med: int = 65
@export var start_health: int = 100
@export var max_health: int = 100



func _ready() -> void:
	level_low =  int(max_health * .3)
	level_med =  int(max_health * .65)
	
	max_value = max_health
	value = start_health
	
	set_color()


func set_color() -> void:
	if value < level_low:
		tint_progress = COLOR_DANGER
	elif value < level_med:
		tint_progress = COLOR_MIDDLE
	else:
		tint_progress = COLOR_GOOD
		
		
func increase_value(v: int) -> void:
	value += v
	if value <= 0:
		died.emit()
	value = min(max_health, value)
	set_color()


func take_damage(v: int) -> void:
	increase_value(-v)
