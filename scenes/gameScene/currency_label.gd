extends Label

var min_font_size : int

func _ready() -> void:
	min_font_size = get_viewport_rect().size.y * 0.07

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_font_size()
	

func update_font_size() -> void:
	var viewport_size = get_viewport_rect().size
	var new_font_size = max(min_font_size, viewport_size.y * 0.07)
	add_theme_font_size_override("font_size", new_font_size)
	
