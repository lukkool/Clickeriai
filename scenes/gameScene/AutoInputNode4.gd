extends Control

signal output_activated(val)

var income_amount: int = 10
var interval: float = 10.0  # Time in seconds between activations
var timer: Timer
var enabled: bool = false

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = interval
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout() -> void:
	output_activated.emit(income_amount)

func set_income_amount(amount: int) -> void:
	income_amount = amount

func set_interval(new_interval: float) -> void:
	interval = new_interval
	timer.wait_time = interval

func set_enabled(is_enabled: bool) -> void:
	enabled = is_enabled
