extends Control

@onready var panel = $Panel

func _toggle_panel() -> void:
	panel.visible = !panel.visible

@onready var tooltip = $Tooltip
var tooltip_active = false

func _ready():
	for button in get_tree().get_nodes_in_group("upgrade_buttons"): #automatically connects upgrade buttons
		button.mouse_entered.connect(func(): show_tooltip(button))
		button.mouse_exited.connect(hide_tooltip)

func _process(_delta):
	if tooltip_active: #keeps tooltip on the mouse position
		tooltip.global_position = get_global_mouse_position() + Vector2(20, 10)

func show_tooltip(button: Button): #shows tooltip by obtaining metadata from the specific button
	if button.has_meta("tooltip_text"):
		tooltip_text = button.get_meta("tooltip_text")
		tooltip.show_tooltip(tooltip_text)
		tooltip_active = true

func hide_tooltip():
	tooltip.hide_tooltip()
	tooltip_active = false
	
