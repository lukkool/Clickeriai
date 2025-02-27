extends ColorRect

signal output_activated

func _ready() -> void:
	var input_node = get_parent().get_node("InputNode")
	input_node.input_activated.connect(_on_input_node_activated)

func _on_input_node_activated() -> void:
	print(name, " got signal")
	output_activated.emit()
	
	
