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
		"dense_layer_nodes": game_scene.dense_layer_nodes,
		"convolutional_layer_nodes": game_scene.convolutional_layer_nodes,
		"recurrent_layer_nodes": game_scene.recurrent_layer_nodes,
		"batch_normalization_layer_nodes": game_scene.batch_normalization_layer_nodes,
		"upgr_auto_input_node1": game_scene.upgr_auto_input_node1,
		"upgr_auto_input_node2": game_scene.upgr_auto_input_node2,
		"upgr_auto_input_node3": game_scene.upgr_auto_input_node3,
		"upgr_auto_input_node4": game_scene.upgr_auto_input_node4
	}
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_var(save_data)
		file.close()
		print("Game saved automatically!")
	else:
		print("Error: Could not save game.")

func load_game():
	if not FileAccess.file_exists(save_path):
		print("No save file found!")
		return
	
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		var save_data = file.get_var()
		file.close()
		
		game_scene.score = save_data["score"]
		game_scene.dense_layer_nodes = save_data["dense_layer_nodes"]
		game_scene.convolutional_layer_nodes = save_data["convolutional_layer_nodes"]
		game_scene.recurrent_layer_nodes = save_data["recurrent_layer_nodes"]
		game_scene.batch_normalization_layer_nodes = save_data["batch_normalization_layer_nodes"]
		game_scene.upgr_auto_input_node1 = save_data["upgr_auto_input_node1"]
		game_scene.upgr_auto_input_node2 = save_data["upgr_auto_input_node2"]
		game_scene.upgr_auto_input_node3 = save_data["upgr_auto_input_node3"]
		game_scene.upgr_auto_input_node4 = save_data["upgr_auto_input_node4"]
		
		print("Game loaded!")
	else:
		print("Error: Could not load game.")
