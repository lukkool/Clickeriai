extends Node

var save_path = "user://savegame.save"
var save_interval = 10.0
var save_timer: float = 0.0

@onready var game_scene = get_parent()

func _ready():
	save_timer = save_interval

func _process(delta):
	save_timer -= delta
	if save_timer <= 0:
		save_game()
		save_timer = save_interval

# Function to save the game
func save_game():
	
	var save_data = {
		"score": game_scene.score,
		"upgrades": game_scene.upgrades,
	}
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_var(save_data)
		file.close()
	else:
		printerr("Error: Could not save game.")

func load_game():
	if not FileAccess.file_exists(save_path): return
	
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		var save_data = file.get_var()
		file.close()
		
		game_scene.score = save_data["score"]
		game_scene.upgrades = save_data["upgrades"]
		game_scene.update_upgrades()
	else:
		printerr("Error: Could not load game.")
