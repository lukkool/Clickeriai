extends Panel

@onready var save_load_manager = get_node("/root/GameScene/SaveLoadManager")

func _ready():
	# Hide the menu initially
	visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = !visible
		#get_tree().paused = visible

func _on_save_pressed():
	
	print("Save button pressed")
	save_load_manager.save_game()
	print("Game saved!")

func _on_save_and_exit_to_main_menu_pressed():
	save_load_manager.save_game()
	Global.switch_scene("res://scenes/mainMenu/MainMenu.tscn", false)  # Switch to main menu

func _on_save_and_exit_to_os_pressed():
	get_tree().paused = false
	print("Save button pressed")
	save_load_manager.save_game()
	get_tree().quit()
