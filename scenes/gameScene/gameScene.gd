extends Control

@onready var score_label:Label = $CurrencyLabel
@onready var output_node:Control = $OutputNode

var score:int:
	set(val):
		score = val
		score_label.text = "Bits:\n" + str(score)


func _ready() -> void:
	output_node.output_activated.connect(func(val): score += val)


var dense_layer_nodes:int = 0
var convolutional_layer_nodes:int = 0
var recurrent_layer_nodes:int = 0
var batch_normalization_layer_nodes:int = 0

var upgr_auto_input_node1:bool = false
var upgr_auto_input_node2:bool = false
var upgr_auto_input_node3:bool = false
var upgr_auto_input_node4:bool = false
