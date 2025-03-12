extends TextureRect

signal score_output(val:float)
var enabled = false

func enable():
	if enabled: return
	enabled = true
	
	visible = true
	$"..".enable()
	
	for node in get_tree().get_nodes_in_group("nodes_layer1"):
		node.score_output.connect(add_and_send)

func add_and_send(val):
	print("sending ", val ** 2)
	score_output.emit(val ** 2)
