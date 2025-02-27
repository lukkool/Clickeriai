extends Control

@onready var panel = $Panel

func _toggle_panel() -> void:
	panel.visible = !panel.visible
