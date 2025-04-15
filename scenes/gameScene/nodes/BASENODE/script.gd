extends TextureRect

signal score_output(val:float)

var enabled:bool = false
var layer:int = -1

func enable():
	if enabled: return
	enabled = true
	
	visible = true
	$"..".enable()
	
	for node in get_tree().get_nodes_in_group("nodes_layer" + str(($"..").get_meta("index") - 1)):
		node.score_output.connect(func(val:float):await get_tree().create_timer(randf_range(0.1, 0.2)).timeout;process_and_send(val))
	
	after_enable()
func after_enable(): pass

func process_and_send(val:float): printerr("PROCESS AND SEND NOT IMPLEMENTED")

func _process(delta: float) -> void:
	modulate = lerp(modulate, Color(1, 1, 1, 1), delta*10)

func lightup():
	modulate = Color(2, 2, 2, 1)
