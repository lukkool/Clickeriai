extends "res://scenes/gameScene/nodes/BASENODE/script.gd"

var emit_chance: float = 0.1  # 10% chance to emit the value

func _ready(): layer = 4
func process_and_emit(val: float):
	if randf() < emit_chance:
		score_output.emit(val)
		lightup()
	score_output.emit(val)
