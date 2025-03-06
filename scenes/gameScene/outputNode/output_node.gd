extends TextureRect

signal output_activated(val)

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("nodes_layer0"):
		node.score_output.connect(on_signal_get)

func on_signal_get(val): output_activated.emit(val)


var current_last_layer:int = 0
func connect_last_layer_to(next):
	reconnect_last_layer(current_last_layer, next)
	current_last_layer = next

func reconnect_last_layer(current, next):
	for node in get_tree().get_nodes_in_group("nodes_layer" + str(current)):
		node.score_output.disconnect(on_signal_get)
		
	for node in get_tree().get_nodes_in_group("nodes_layer" + str(next)):
		node.score_output.connect(on_signal_get)
