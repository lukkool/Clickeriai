extends Control

@export var offset := Vector2(20, 10)

func show_tooltip(text: String):
	$Panel_Tooltip/Label2.text = text
	show()
	
func hide_tooltip():
	hide()
	

	
