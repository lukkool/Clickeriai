extends Button

signal input_activated

func _on_pressed() -> void:
	print(name, " pressed")
	input_activated.emit()
