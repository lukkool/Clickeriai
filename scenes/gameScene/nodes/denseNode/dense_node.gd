extends "res://scenes/gameScene/nodes/BASENODE/script.gd"

var stored_values: Array = []
var active_dense_nodes: int = 0

func _ready(): layer = 2

func _after():
	stored_values.clear()
	

func process_and_send(val:float): store_value(val)

func get_num_enabled():
	var active_nodes = 0
	for node in get_tree().get_nodes_in_group("nodes_layer1"):
		if node.enabled:
			active_nodes += 1
	return active_nodes
	

func store_value(val: float):
	stored_values.append(val)
	
	if len(stored_values) >= get_num_enabled():
		calculate_and_emit()

func calculate_and_emit():
	var result: float = stored_values[0]
	for value in stored_values.slice(1):
		result *= value
	
	score_output.emit(result)
	stored_values = []
	lightup()
