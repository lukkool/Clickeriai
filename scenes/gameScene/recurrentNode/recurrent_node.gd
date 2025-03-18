extends TextureRect

signal score_output(val: float)

var enabled = false
var emit_chance: float = 0.1  # 10% chance to emit the value

func enable():
	if enabled: return
	enabled = true
	
	visible = true
	$"..".enable()
	
	for node in get_tree().get_nodes_in_group("nodes_layer3"):
		node.score_output.connect(process_value)

func process_value(val: float):
	if randf() < emit_chance:
		score_output.emit(val)
	score_output.emit(val)
