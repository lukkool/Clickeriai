extends TextureRect

signal score_output(val:float)

var bonus:float = 1
var enabled = false

func enable():
	if enabled: return
	enabled = true
	
	visible = true
	$"..".enable()
	
	for node in get_tree().get_nodes_in_group("nodes_layer0"):
		node.score_output.connect(add_and_send)

func add_and_send(val):
	score_output.emit(val + bonus)
	lightup()

func _process(delta: float) -> void:
	modulate = lerp(modulate, Color(1, 1, 1, 1), delta*10)

func lightup():
	modulate = Color(2, 2, 2, 1)
