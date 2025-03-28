extends AudioStreamPlayer

func _process(delta: float) -> void:
	if get_playback_position() > 119.999: play()
