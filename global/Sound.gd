extends Node

var click_sound = preload("res://global/buttonClicked.wav")


func play_button_click(sound = click_sound, volume = 0):
	var audio = AudioStreamPlayer.new()
	add_child(audio)
	audio.stream = sound
	audio.volume_db = volume
	audio.play()
	await audio.finished
	audio.queue_free()
