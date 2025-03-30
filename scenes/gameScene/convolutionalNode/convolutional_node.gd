extends TextureRect

signal score_output(val:float)
var enabled = false

func enable():
	if enabled: return
	enabled = true
	
	visible = true
	$"..".enable()
	
	for node in get_tree().get_nodes_in_group("nodes_layer2"):
		node.score_output.connect(add_and_send)

func add_and_send(val):
	lightup()
	score_output.emit(val ** 2)
	
func _process(delta: float) -> void:
	modulate = lerp(modulate, Color(1, 1, 1, 1), delta*10)

func lightup():
	modulate = Color(0.6, 0.6, 1)
