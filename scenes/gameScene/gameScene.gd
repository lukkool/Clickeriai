extends Control

@onready var score_label:Label = $CurrencyLabel
@onready var output_node:Control = $OutputNode
@onready var auto_input_node: Control = $AutoInputNode
@onready var auto_input_node2: Control = $AutoInputNode2
@onready var auto_input_node3: Control = $AutoInputNode3
@onready var auto_input_node4: Control = $AutoInputNode4

var score:int:
	set(val):
		score = val
		score_label.text = "Bits:\n" + str(score)

var should_load: bool

func _ready() -> void:
	if should_load:
		get_node("SaveLoadManager").load_game()
	output_node.output_activated.connect(func(val): score += val)
	auto_input_node.set_enabled(false)
	auto_input_node2.set_enabled(false)
	auto_input_node3.set_enabled(false)
	auto_input_node4.set_enabled(false)


var dense_layer_nodes:int = 0
var convolutional_layer_nodes:int = 0
var recurrent_layer_nodes:int = 0
var batch_normalization_layer_nodes:int = 0

var upgr_auto_input_node1:bool = false
var upgr_auto_input_node2:bool = false
var upgr_auto_input_node3:bool = false
var upgr_auto_input_node4:bool = false
