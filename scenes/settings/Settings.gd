extends Control

const RESOLUTIONS: Dictionary = {
	"3840x2160": Vector2i(3840, 2160),
	"2560x1440": Vector2i(2560, 1440),
	"1920x1080": Vector2i(1920, 1080),
	"1600x900": Vector2i(1600, 900),
	"1280x720": Vector2i(1280, 720),
	"640x360": Vector2i(640, 360)
}
const RESOLUTION_KEYS: Array[String] = [
	"3840x2160",
	"2560x1440",
	"1920x1080",
	"1600x900",
	"1280x720",
	"640x360"
]
@onready var resolution_option_button: OptionButton = $VolumeSettings/VBoxContainer/ResolutionOptionButton

func _ready() -> void:
	populate_resolution_options()
	select_current_resolution()
	resolution_option_button.item_selected.connect(_on_resolution_option_button_item_selected)


func populate_resolution_options() -> void:
	resolution_option_button.clear()
	var screen_size: Vector2i = DisplayServer.screen_get_size(DisplayServer.get_primary_screen())
	print("Screen size detected: ", screen_size)

	var added_any = false
	for res_string in RESOLUTION_KEYS:
		if RESOLUTIONS.has(res_string):
			var res_vector: Vector2i = RESOLUTIONS[res_string]
			if res_vector.x <= screen_size.x and res_vector.y <= screen_size.y:
				resolution_option_button.add_item(res_string)
				added_any = true
			else:
				print("Skipping resolution (too large): ", res_string)

	if not added_any:
		var screen_size_str = "%sx%s" % [screen_size.x, screen_size.y]
		if not RESOLUTIONS.has(screen_size_str):
			resolution_option_button.add_item(screen_size_str)

func select_current_resolution() -> void:
	var current_size: Vector2i = DisplayServer.window_get_size()
	var current_size_string: String = "%sx%s" % [current_size.x, current_size.y]

	var found_index: int = -1
	for i in RESOLUTION_KEYS.size():
		if RESOLUTION_KEYS[i] == current_size_string:
			found_index = i
			break

	if found_index != -1:
		resolution_option_button.select(found_index)
	else:
		print("Current resolution %s not found in predefined list." % current_size_string)
		if resolution_option_button.item_count > 0:
			resolution_option_button.select(0)

func _on_button_back_pressed() -> void:
	Global.switch_scene("res://scenes/mainMenu/MainMenu.tscn")
	Sound.play_button_click()

func _on_resolution_option_button_item_selected(index: int) -> void:
	var selected_res_string: String = resolution_option_button.get_item_text(index)
	if RESOLUTIONS.has(selected_res_string):
		var new_size: Vector2i = RESOLUTIONS[selected_res_string]
		print("Changing resolution to: ", new_size)
		DisplayServer.window_set_size(new_size)
		DisplayServer.window_set_position(DisplayServer.screen_get_position() + (DisplayServer.screen_get_size() - new_size) / 2)
	else:
		printerr("Selected resolution string '%s' not found in RESOLUTIONS dictionary!" % selected_res_string)
