extends Control

signal score_output(val)

@export var income_amount: int = 1
@export var interval: float = 10.0
var enabled: bool = false

var delay = interval
func _process(delta: float) -> void:
	if not enabled: return
	
	delay -= delta
	if delay <= 0:
		delay = interval
		score_output.emit(income_amount)
