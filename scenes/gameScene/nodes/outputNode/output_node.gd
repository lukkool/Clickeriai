extends TextureRect


signal output_activated(val)
var output_multiplier:float = 1.0

var number_pool: Array = []
const MAX_NUMBERS = 50

var nodes = [self]
var enabled = true
var ascension_base_mult = 1

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
	
	for i in range(MAX_NUMBERS):
		var label = Label.new()
		label.visible = false
		add_child(label)
		number_pool.append(label)

func on_signal_get(val):
	val = (val * output_multiplier * ascension_base_mult)
	
	
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

func show_number(value: float):
	var label = get_pooled_label()
	if not label:
		return
	
	label.text = "+" + str(value)
	label.modulate = Color(1, 1, 1, 1)
	label.position = Vector2(35 - (label.text.length() * 5.5), -30)
	label.visible = true

	var tween = get_tree().create_tween()
	tween.tween_property(label, 'position', label.position - Vector2(0, 60), 0.9).set_trans(Tween.TRANS_SINE)
	tween.tween_property(label, 'modulate:a', 0.0, 0.6)
	tween.connect("finished", func():
		if is_instance_valid(label):
			label.visible = false
	)

func get_pooled_label() -> Label:
	for label in number_pool:
		if not label.visible:
			return label
	return null 

func apply_output_multiplier(output_upgrade: float):
	output_multiplier = output_upgrade
	
	
