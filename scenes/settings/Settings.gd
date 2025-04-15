extends Control

# Predefined list of resolutions (String -> Vector2i)
const RESOLUTIONS: Dictionary = {
	"3840x2160": Vector2i(3840, 2160),
	"2560x1440": Vector2i(2560, 1440),
	"1920x1080": Vector2i(1920, 1080),
	"1600x900": Vector2i(1600, 900),
	"1280x720": Vector2i(1280, 720),
	"640x360": Vector2i(640, 360)
}
# Store the resolution strings in order for predictable index mapping
const RESOLUTION_KEYS: Array[String] = [
	"3840x2160",
	"2560x1440",
	"1920x1080",
	"1600x900",
	"1280x720",
	"640x360"
]

# Get references to the UI elements (Adjust the paths if needed!)
# Using %UniqueName syntax is recommended if you set unique names in the editor
# Example: @onready var resolution_option_button: OptionButton = %ResolutionOptionButton
@onready var resolution_option_button: OptionButton = $VolumeSettings/VBoxContainer/ResolutionOptionButton


# --- Godot Lifecycle Functions ---

func _ready() -> void:
	populate_resolution_options()
	select_current_resolution()
	# Connect the signal when an item is selected in the dropdown
	resolution_option_button.item_selected.connect(_on_resolution_option_button_item_selected)

# --- UI Setup Functions ---

func populate_resolution_options() -> void:
	resolution_option_button.clear() # Remove any default/previous items
	var screen_size: Vector2i = DisplayServer.screen_get_size(DisplayServer.get_primary_screen())
	print("Screen size detected: ", screen_size) # Debug output

	var added_any = false
	for res_string in RESOLUTION_KEYS:
		if RESOLUTIONS.has(res_string):
			var res_vector: Vector2i = RESOLUTIONS[res_string]
			# Only add the resolution if it's less than or equal to the screen size
			if res_vector.x <= screen_size.x and res_vector.y <= screen_size.y:
				resolution_option_button.add_item(res_string)
				added_any = true
			else:
				print("Skipping resolution (too large): ", res_string) # Debug output

	# Fallback: If no standard resolutions fit (unlikely), maybe add the screen's native size?
	if not added_any:
		var screen_size_str = "%sx%s" % [screen_size.x, screen_size.y]
		 # Add if not already in our main dictionary, or just add it anyway
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
		# Optional: Handle case where current resolution isn't in our list
		# Maybe add it dynamically or select a default?
		# For now, we'll just leave it unselected or on the first item (index 0)
		print("Current resolution %s not found in predefined list." % current_size_string)
		if resolution_option_button.item_count > 0:
			resolution_option_button.select(0) # Select the first item as a fallback


# --- Signal Handlers ---

func _on_button_back_pressed() -> void:
	# Optional: Save settings before switching scene
	# save_settings()
	Global.switch_scene("res://scenes/mainMenu/MainMenu.tscn")
	Sound.play_button_click() # Assuming Sound is an autoload

func _on_resolution_option_button_item_selected(index: int) -> void:
	var selected_res_string: String = resolution_option_button.get_item_text(index)
	if RESOLUTIONS.has(selected_res_string):
		var new_size: Vector2i = RESOLUTIONS[selected_res_string]
		print("Changing resolution to: ", new_size)
		DisplayServer.window_set_size(new_size)
		# Optional: Center the window after resizing
		DisplayServer.window_set_position(DisplayServer.screen_get_position() + (DisplayServer.screen_get_size() - new_size) / 2)
		# Optional: Save the selected resolution preference
		# save_settings() # Call a function to save the selected index or string
	else:
		printerr("Selected resolution string '%s' not found in RESOLUTIONS dictionary!" % selected_res_string)


# --- Optional Saving/Loading ---
# Add functions here if you want to save/load the selected resolution
# using ConfigFile or your Global autoload

# func save_settings():
#	var config = ConfigFile.new()
#	# Load existing config if it exists
#	config.load("user://settings.cfg")
#	var selected_res_index = resolution_option_button.selected
#	if selected_res_index >= 0:
#		config.set_value("display", "resolution_index", selected_res_index)
#		# Or save the string: config.set_value("display", "resolution_string", resolution_option_button.get_item_text(selected_res_index))
#	config.save("user://settings.cfg")

# func load_settings():
#	var config = ConfigFile.new()
#	var err = config.load("user://settings.cfg")
#	if err == OK:
#		var loaded_index = config.get_value("display", "resolution_index", -1) # Default to -1 if not found
#		if loaded_index >= 0 and loaded_index < resolution_option_button.item_count:
#			resolution_option_button.select(loaded_index)
#			# IMPORTANT: Apply the loaded resolution immediately if needed
#			_on_resolution_option_button_item_selected(loaded_index) # Re-use the logic to apply
#		else:
#			select_current_resolution() # Fallback if saved index is invalid
#	else:
#		select_current_resolution() # Fallback if file doesn't exist

# You would call load_settings() in _ready() before connecting signals
# and save_settings() when closing settings or applying changes.
