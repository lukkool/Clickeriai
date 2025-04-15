extends "res://scenes/gameScene/nodes/BASENODE/script.gd"

var bonus:float = 1
func _ready(): layer = 1

func process_and_send(val:float):
	score_output.emit(val + bonus)
	lightup()
