extends Node

var click_sound = preload("res://global/buttonClicked.wav")

func play_button_click():
	var audio = AudioStreamPlayer.new()
	add_child(audio)
	audio.stream = click_sound
	audio.play()
	await audio.finished
	audio.queue_free()
