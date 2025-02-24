extends Sprite2D


func _input(event) -> void:
	if event.is_action_pressed("click"):
		if is_pixel_opaque(get_local_mouse_position()):
			print("Clicked")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
