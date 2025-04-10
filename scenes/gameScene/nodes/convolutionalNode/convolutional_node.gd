extends "res://scenes/gameScene/nodes/BASENODE/script.gd"

func _ready(): layer = 2

func process_and_send(val:float):
	score_output.emit(val ** 2)
	lightup()
