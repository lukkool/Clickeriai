extends Control

@onready var score_label:Label = $CurrencyLabel
@onready var output_node:Control = $%OutputNode

var score:float:
	set(val):
		score = val
		score_label.text = "Bits:\n" + str(score)

var should_load: bool

func _ready() -> void:
	if should_load:
		get_node("SaveLoadManager").load_game()
	output_node.output_activated.connect(func(val): score += val)

var upgrades = {
	"AutoInputNode1": false,
	"AutoInputNode2": false,
	"AutoInputNode3": false,
	"AutoInputNode4": false,
	
	"BatchNormalizationNode1": false,
	"BatchNormalizationNode2": false,
	"BatchNormalizationNode3": false,
	"BatchNormalizationNode4": false,
	"BatchNormalizationNode5": false,
	"BatchNormalizationNode6": false,
	
	"DenseNode1": false,
	"DenseNode2": false,
	"DenseNode3": false,
	"DenseNode4": false,
	"DenseNode5": false,
	"DenseNode6": false,
	
	"ConvolutionalNode1": false,
	"ConvolutionalNode2": false,
	"ConvolutionalNode3": false,
	"ConvolutionalNode4": false,
	"ConvolutionalNode5": false,
	"ConvolutionalNode6": false,
	
	"RecurrentNode1": false,
	"RecurrentNode2": false,
	"RecurrentNode3": false,
	"RecurrentNode4": false,
	"RecurrentNode5": false,
	"RecurrentNode6": false,
}

func update_upgrades():
	for i in range(1, 5):
		if upgrades["AutoInputNode" + str(i)]: get_node("LayerContainer/Layer0/AutoInputNode" + str(i)).enabled = true
	
	for i in range(1, 7):
		if upgrades["BatchNormalizationNode" + str(i)]: get_node("LayerContainer/Layer1/BatchNormalizationNode" + str(i)).enable()

	for i in range(1, 7):
		if upgrades["DenseNode" + str(i)]: get_node("LayerContainer/Layer2/DenseNode" + str(i)).enable()

	for i in range(1, 7):
		if upgrades["ConvolutionalNode" + str(i)]: get_node("LayerContainer/Layer3/ConvolutionalNode" + str(i)).enable()
	
	for i in range(1, 7):
		if upgrades["RecurrentNode" + str(i)]: get_node("LayerContainer/Layer4/RecurrentNode" + str(i)).enable()
	#ATTENTION - Add later implemented upgrades


func _on_save_and_exit_to_os_pressed() -> void:
	pass # Replace with function body.
