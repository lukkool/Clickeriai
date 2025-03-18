extends VBoxContainer

var enabled = false
@onready var output_node = $%OutputNode

func enable():
	if enabled: return
	enabled = true
	
	visible = true
	output_node.connect_last_layer_to(3)
