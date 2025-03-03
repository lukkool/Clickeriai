extends Control

@onready var button_continue = $ButtonContinue

func _ready():
	if FileAccess.file_exists("user://savegame.save"):
		button_continue.disabled = false
	else:
		button_continue.disabled = true

func _on_button_start_pressed() -> void:
	Global.switch_scene("res://scenes/gameScene/gameScene.tscn", false)


func _on_button_leaderboard_pressed() -> void:
	Global.switch_scene("res://scenes/leaderboard/Leaderboard.tscn", false)


func _on_button_settings_pressed() -> void:
	Global.switch_scene("res://scenes/settings/Settings.tscn", false)


func _on_button_exit_pressed() -> void:
	get_tree().quit()


func _on_button_continue_pressed() -> void:
	Global.switch_scene("res://scenes/gameScene/gameScene.tscn", true)
	
