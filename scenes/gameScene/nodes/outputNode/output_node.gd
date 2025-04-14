extends TextureRect


signal output_activated(val)

var nodes = [self]
var enabled = true

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("nodes_layer0"):
		node.score_output.connect(on_signal_get)
		
	randomize()
	for node in nodes:
		if node.material and node.material is ShaderMaterial:
			var shader_material = node.material as ShaderMaterial
			var rand_x = randf() * 100.0
			var rand_y = randf() * 100.0
			shader_material.set_shader_parameter("rand_seed", Vector2(rand_x, rand_y))

func on_signal_get(val):
	output_activated.emit(val)
	show_number(val)


var current_last_layer:int = 0
func connect_last_layer_to(next):
	reconnect_last_layer(current_last_layer, next)
	current_last_layer = next


func reconnect_last_layer(current, next):
	for node in get_tree().get_nodes_in_group("nodes_layer" + str(current)):
		node.score_output.disconnect(on_signal_get)
		
	for node in get_tree().get_nodes_in_group("nodes_layer" + str(next)):
		node.score_output.connect(on_signal_get)

func update(): pass

func show_number(value: int):
	
	var label = Label.new()
	label.text = "+" + str(value)
	var offset = Vector2(35 - (label.text.length() * 5.5), -30)
	label.modulate = Color(1, 1, 1, 1)
	label.position = offset
	add_child(label)
	
	var tween = get_tree().create_tween()
	tween.tween_property(
		label, 'position',
		offset - Vector2(0, 60), 0.9
	).set_trans(Tween.TRANS_SINE)
		
	tween.tween_property(label, 'modulate:a', 0.0, 0.6)
	tween.connect(
		"finished",
		func():
			label.queue_free()
	)
		
