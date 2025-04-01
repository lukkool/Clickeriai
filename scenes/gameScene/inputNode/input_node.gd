extends Button

signal score_output(val)

var base_click_value = 1
var enabled: bool = true
var target_streak_multiplier_value = 2
var current_streak_multiplier = 1

var click_streak = 0
var needed_threshold = 20
var multiplier_timer: float = 0.0
var multiplier_duration: float = 10.0
var multiplier_active = false
var normal_color = Color(1, 1, 1)
var multiplier_color = Color(1, 0, 0)
const INPUT_SOUND = preload("res://scenes/gameScene/inputNode/input_sound.ogg")

@onready var progress_bar: ProgressBar = get_node_or_null("/root/GameScene/ProgressBar")

func _ready():
	if progress_bar == null:
		push_warning("Progress bar not found at /root/GameScene/ProgressBar")
	else:
		progress_bar.max_value = needed_threshold
		progress_bar.value = 0
	self.modulate = normal_color

func set_target_streak_multiplier(value: int):
	target_streak_multiplier_value = value


func _process(delta: float) -> void:
	if progress_bar == null: return

	if multiplier_active:
		multiplier_timer -= delta
		progress_bar.value = (multiplier_timer / multiplier_duration) * needed_threshold
		if multiplier_timer <= 0:
			multiplier_active = false
			current_streak_multiplier = 1
			self.modulate = normal_color
			click_streak = 0
			progress_bar.value = 0

	elif click_streak > 0:
		var decay_rate = 1.0
		click_streak = max(0.0, click_streak - decay_rate * delta)
		progress_bar.value = click_streak


func _on_pressed() -> void:
	if progress_bar == null:
		push_warning("Cannot process click, progress bar not found.")
		score_output.emit(base_click_value)
		Sound.play_button_click(INPUT_SOUND, -12)
		return

	if not multiplier_active:
		click_streak = min(needed_threshold, click_streak + 1)
		progress_bar.value = click_streak

		if click_streak >= needed_threshold:
			current_streak_multiplier = target_streak_multiplier_value
			multiplier_active = true
			multiplier_timer = multiplier_duration
			self.modulate = multiplier_color
	var final_score_generated = base_click_value * current_streak_multiplier
	score_output.emit(final_score_generated)

	Sound.play_button_click(INPUT_SOUND, -12)
