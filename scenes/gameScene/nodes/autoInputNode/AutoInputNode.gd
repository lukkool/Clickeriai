extends Control

signal score_output(val:float)

@export var income_amount: int = 1
@export var interval: float = 1.0

var base_income_amount: int

var enabled: bool = false:
	set(val):
		enabled = val
		visible = enabled
		$"..".enable()

var delay = randf_range(0, interval)

func _ready():
	base_income_amount = income_amount
	
func _process(delta: float) -> void:
	if not enabled: return
	
	delay -= delta
	if delay <= 0:
		delay = interval
		score_output.emit(income_amount)
		lightup()
		
	modulate = lerp(modulate, Color(1, 1, 1, 1), delta * 10.)
	
func apply_income_multiplier(multiplier: int):
	if base_income_amount == 0 and income_amount != 0:
		base_income_amount = income_amount
		
	income_amount = base_income_amount * multiplier

func apply_speed(interval_upgraded: float):
	interval = interval_upgraded
	
func lightup():
	modulate = Color(2, 2, 2, 1)
