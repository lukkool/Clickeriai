extends Control

@onready var score_label:Label = $CurrencyLabel
@onready var output_node:Control = $OutputNode

var score:int:
	set(val):
		score = val
		score_label.text = "Bits:\n" + str(score)


func _ready() -> void:
	output_node.output_activated.connect(func(val): score += val)
