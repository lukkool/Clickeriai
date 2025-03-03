extends Button

func _ready():
	self.pressed.connect(_on_pressed)

func _on_pressed():
	# Call the load_game function from the SaveLoadManager node
	get_node("../SaveLoadManager").load_game()
