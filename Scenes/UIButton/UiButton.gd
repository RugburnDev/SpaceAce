extends TextureButton

@onready var label: Label = $Label


@export var _text : String = "Set Me"



func _ready() -> void:
	label.text = _text
