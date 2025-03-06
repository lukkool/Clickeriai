extends TextureRect

signal score_output(val:float)

var bonus:int = 1

func enable():
	visible = true
	for node in get_tree().get_nodes_in_group("nodes_layer0"):
		node.score_output.connect(add_and_send)

func add_and_send(val):
	score_output.emit(val + bonus)
