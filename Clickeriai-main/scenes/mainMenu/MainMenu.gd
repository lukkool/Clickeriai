extends Control



func _on_button_start_pressed() -> void:
	Global.switch_scene("res://scenes/gameScene/gameScene.tscn")


func _on_button_leaderboard_pressed() -> void:
	Global.switch_scene("res://scenes/leaderboard/Leaderboard.tscn")


func _on_button_settings_pressed() -> void:
	Global.switch_scene("res://scenes/settings/Settings.tscn")


func _on_button_exit_pressed() -> void:
	get_tree().quit()
