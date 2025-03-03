extends Control


func _on_button_back_pressed() -> void:
	Global.switch_scene("res://scenes/mainMenu/MainMenu.tscn")
	Sound.play_button_click()
