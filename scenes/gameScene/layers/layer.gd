extends VBoxContainer

var enabled = false
@onready var output_node = $%OutputNode
@export var layer_number:int
@onready var nodes = get_children()
@onready var layers = $"..".get_children()

func _ready():
	if layer_number == 0: enable()
	layers.remove_at(len(layers)-1)

func enable():
	if not enabled:
		enabled = true
		visible = true
		output_node.connect_last_layer_to(layer_number)
		for layer in layers:
			if not layer == self: layer.update()
	
	if layer_number > 0: layers[layer_number - 1].update()
	update()

func update():
	await get_tree().process_frame
	await get_tree().process_frame
	draw_lines()

var lines = []
func draw_lines():
	if not enabled: return
	
	for line in lines: line.queue_free()
	lines = []
	
	var right_nodes:Array
	if layer_number == output_node.current_last_layer:
		right_nodes = [output_node]
	else:
		right_nodes = layers[layer_number + 1].nodes
	
	for right_node:Control in right_nodes:
		for left_node:Control in nodes:
			if not left_node.enabled or not right_node.enabled: continue
			
			var line = preload("res://scenes/gameScene/misc/lines_between_nodes/line.tscn").instantiate()
			var right_center:Vector2 = right_node.get_global_rect().get_center()
			var left_center:Vector2 = left_node.get_global_rect().get_center()
			
			line.global_position = left_center
			line.add_point(right_center - left_center)
			line.connect_parent(left_node)
			lines.append(line)
			
			get_tree().root.get_child(-1).add_child(line)
			get_tree().root.get_child(-1).move_child(line, 1)
