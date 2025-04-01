extends Button

signal score_output(val)
var multiplier = 1
var score_generated = 1
var score_per_click = 1
var enabled = true

var click_streak = 0
var needed_threshold = 20
var multiplier_timer: float = 0.0
var multiplier_duration: float = 10.0
var multiplier_active = false
var normal_color = Color(1, 1, 1)
var multiplier_color = Color(1, 0, 0)
var input_sound = preload("res://scenes/gameScene/inputNode/input_sound.ogg")

@onready var progress_bar: ProgressBar = get_node("/root/GameScene/ProgressBar")


func _process(delta: float) -> void:
	if multiplier_active:
		multiplier_timer -= delta
		progress_bar.value = (multiplier_timer/multiplier_duration) * needed_threshold
		if multiplier_timer <= 0:
			multiplier_active = false
			multiplier = 1
			self.modulate = normal_color
			
	if not multiplier_active:
		progress_bar.value -= 1 * delta
		click_streak -= 1 * delta
		
		
	
		


func _on_pressed() -> void:
	if not multiplier_active:
		click_streak += 1
		progress_bar.value += 1
	if(click_streak >= needed_threshold):
		multiplier *= 2
		click_streak = 0
		multiplier_active = true
		multiplier_timer = multiplier_duration
		self.modulate = multiplier_color
		
	score_generated = multiplier * score_per_click
	score_output.emit(score_generated)
	
	Sound.play_button_click(input_sound, -12)
	
func set_upgrade_level(level: int):
	score_per_click += 3 * level
