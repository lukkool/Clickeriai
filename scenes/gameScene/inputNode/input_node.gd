extends Button

signal input_activated(val)
var score_generated = 1

func _on_pressed() -> void:
	input_activated.emit(score_generated)
