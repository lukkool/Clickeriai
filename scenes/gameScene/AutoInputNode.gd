extends Control

signal score_output(val:float)

@export var income_amount: int = 1
@export var interval: float = 1.0
var enabled: bool = false:
	set(val):
		enabled = val
		visible = enabled
		$"..".enable()

var delay = randf_range(0, interval)
func _process(delta: float) -> void:
	if not enabled: return
	
	delay -= delta
	if delay <= 0:
		delay = interval
		score_output.emit(income_amount)
	
