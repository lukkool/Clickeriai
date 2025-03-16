extends TextureRect

signal score_output(val:float)

var enabled = false

var stored_values: Dictionary = {}
var active_dense_nodes: int = 0

func enable():
	if enabled: return
	enabled = true
	
	visible = true
	$"..".enable()
	
	stored_values.clear()
	
	for node in get_tree().get_nodes_in_group("nodes_layer2"):
		if node.enabled:
			active_dense_nodes += 1
	
	for node in get_tree().get_nodes_in_group("nodes_layer1"):
		node.score_output.connect(store_value.bind(node))

func store_value(val: float, source_node):
	stored_values[source_node] = val
	print("reached1")
	
	if stored_values.size() >= active_dense_nodes and active_dense_nodes > 0:
		calculate_and_emit()

func calculate_and_emit():
	var result: float = stored_values.values()[0]
	
	for value in stored_values.values():
		print("nodes: ", value)
		result *= value
	
	score_output.emit(result)
	stored_values.clear()
