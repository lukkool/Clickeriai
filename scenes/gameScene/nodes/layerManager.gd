extends HBoxContainer


@export var float_amplitude := 10.0  # vertical movement in pixels
@export var float_speed := 2.0       # speed of the wave
@export var wave_spacing := 0.5      # phase offset between each VBox

var base_y_positions := []
var elapsed_time := 0.0

func _ready() -> void:
	# Store the base Y positions of both VBoxContainers and TextureRects
	for child in get_children():
		if child is Control:  # Controls include VBoxContainer, TextureRect, etc.
			base_y_positions.append(child.position.y)
		else:
			base_y_positions.append(null)  # Placeholder for other non-Control nodes

func _process(delta):
	elapsed_time += delta

	for i in range(get_child_count()):
		var child = get_child(i)
		
		if child is Control and base_y_positions[i] != null:  # Process Controls only
			var base_y = base_y_positions[i]
			var offset_y = sin(elapsed_time * float_speed + i * wave_spacing) * float_amplitude
			child.position.y = base_y + offset_y
