extends Button

signal input_activated(val)
var multiplier = 1
var score_generated = 1

var click_streak = 0
var needed_threshold = 20
var multiplier_timer: float = 0.0
var multiplier_duration: float = 10.0
var multiplier_active = false
var normal_color = Color(1, 1, 1)
var multiplier_color = Color(1, 0, 0)


func _process(delta: float) -> void:
	if multiplier_active:
		multiplier_timer -= delta
		if multiplier_timer <= 0:
			multiplier_active = false
			multiplier = 1
			self.modulate = normal_color
	


func _on_pressed() -> void:
	if not multiplier_active:
		click_streak += 1
	print(click_streak)
	if(click_streak > needed_threshold):
		multiplier *= 2
		click_streak = 0
		multiplier_active = true
		multiplier_timer = multiplier_duration
		self.modulate = multiplier_color
	score_generated = multiplier * 1
	input_activated.emit(score_generated)


var dense_layer_nodes:int = 0
var convolutional_layer_nodes:int = 0
var recurrent_layer_nodes:int = 0
var batch_normalization_layer_nodes:int = 0

var upgr_auto_input_node1:bool = false
var upgr_auto_input_node2:bool = false
var upgr_auto_input_node3:bool = false
var upgr_auto_input_node4:bool = false
