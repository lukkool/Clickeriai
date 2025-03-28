extends Line2D

func connect_parent(parent):
	parent.connect("score_output", light_up)

func _process(delta: float) -> void:
	modulate = lerp(modulate, Color(1, 1, 1, 1), delta * 10)

func light_up(val):
	modulate = Color(10, 10, 10, 1)
