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
var input_sound = preload("res://scenes/gameScene/nodes/inputNode/input_sound.ogg")

@onready var progress_bar: TextureProgressBar = get_node("/root/GameScene/ProgressBar")

const CLICK_LIMIT:int = 18
var click_limit_counter:int = 0
const CLICK_LIMIT_TIME:float = 1
var click_limit_time:float = 0

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
		if click_streak > 0:
			click_streak -= 1 * delta
	
	click_limit_time -= delta
		

func _on_pressed() -> void:
	if click_limit_time <= 0:
		click_limit_counter = 0
		click_limit_time = CLICK_LIMIT_TIME
	
	click_limit_counter += 1
	if click_limit_counter > CLICK_LIMIT: return
	
	
	
	
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
	score_per_click = 1 + (level)
