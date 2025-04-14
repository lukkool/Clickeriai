extends Line2D

var left_node : Control
var right_node : Control
var offset

func connect_parent(parent):
	parent.connect("score_output", light_up)

func _process(delta: float) -> void:
	modulate = lerp(modulate, Color(1, 1, 1, 1), delta * 10)

	if left_node and right_node:
		var t = Time.get_ticks_msec() / 1000.0
		
		var left_seed = Vector2(0, 0)
		var right_seed = Vector2(0, 0)
		
		if left_node.material is ShaderMaterial:
			left_seed = left_node.material.get_shader_parameter("rand_seed")

		if right_node.material is ShaderMaterial:
			right_seed = right_node.material.get_shader_parameter("rand_seed")

		var left_jitter = Vector2(
			sin(t * pseudo_random(left_seed)) * 5.0,
			cos(t * pseudo_random(Vector2(left_seed.y, left_seed.x))) * 5.0
		)

		var right_jitter = Vector2(
			sin(t * pseudo_random(right_seed)) * 5.0,
			cos(t * pseudo_random(Vector2(right_seed.y, right_seed.x))) * 5.0
		)
		
		if left_node.material is ShaderMaterial:
			left_node.material.set_shader_parameter("jitter_offset", left_jitter)
		
		if right_node.material is ShaderMaterial:
			right_node.material.set_shader_parameter("jitter_offset", right_jitter)

		var left_center = left_node.get_global_rect().get_center() + left_jitter
		var right_center = right_node.get_global_rect().get_center() + right_jitter

		global_position = left_center
		set_point_position(1, (right_center - left_center))

func pseudo_random(seed: Vector2) -> float:
	var value = sin(seed.dot(Vector2(12.9898, 78.233))) * 43758.5453
	return value - floor(value)

func light_up(val):
	modulate = Color(10, 10, 10, 1)
