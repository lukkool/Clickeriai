extends Button

signal input_activated(val)
var score_generated = 1

func _on_pressed() -> void:
	input_activated.emit(score_generated)


var dense_layer_nodes:int = 0
var convolutional_layer_nodes:int = 0
var recurrent_layer_nodes:int = 0
var batch_normalization_layer_nodes:int = 0

var upgr_auto_input_node1:bool = false
var upgr_auto_input_node2:bool = false
var upgr_auto_input_node3:bool = false
var upgr_auto_input_node4:bool = false
