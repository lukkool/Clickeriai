extends VBoxContainer

var enabled = false
@onready var output_node = $%OutputNode
@export var layer_number:int

func enable():
	if enabled: return
	enabled = true
	
	visible = true
	output_node.connect_last_layer_to(layer_number)
