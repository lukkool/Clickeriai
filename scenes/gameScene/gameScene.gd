extends Control

@onready var score_label:Label = $HBoxContainer/CurrencyLabel
@onready var output_node:Control = $%OutputNode

var score:float:
	set(val):
		score = val
		score_label.text = format_number(score)

func format_number(value: float) -> String:
	var suffixes = ["", "K", "M", "B", "T", "Q", "QI", "SX", "SP", "OC", "N", "DC"]
	var index = 0

	while abs(value) >= 1000.0 and index < suffixes.size() - 1:
		value /= 1000.0
		index += 1

	var formatted = "%.1f" % value
	if formatted.ends_with(".0"):
		formatted = str(int(value))

	return formatted + suffixes[index]

var should_load: bool

func _ready() -> void:
	if should_load:
		get_node("SaveLoadManager").load_game()
	output_node.output_activated.connect(func(val): score += val)
	update_upgrades()

var upgrades = {
	"ManualInputUpgrade1": false,
	"ManualInputUpgrade2": false,
	"ManualInputUpgrade3": false,
	"ManualInputUpgrade4": false,
	
	"AutoInputNode1": false,
	"AutoInputNode2": false,
	"AutoInputNode3": false,
	"AutoInputNode4": false,
	
	"AutoSpeed1": false,
	"AutoSpeed2": false,
	"AutoSpeed3": false,
	
	"AutoInputIncomeDouble": false,
	
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
	
	"OutputMultiplier1": false,
	"OutputMultiplier2": false,
	"OutputMultiplier3": false,
}

func update_upgrades():
	for i in range(4, 0, -1):
		if upgrades["ManualInputUpgrade" + str(i)]: 
			get_node("LayerContainer/Layer0/InputNode").set_upgrade_level(i);
			break;
	
	var interval: float = 1.0
	for i in range(3, 0, -1):
		if upgrades["AutoSpeed" + str(i)]: 
			interval /= (1 + i)
			break;
	
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
	
	var income_multiplier = 1
	if upgrades["AutoInputIncomeDouble"]:
		income_multiplier = 2

	var auto_input_parent = get_node_or_null("LayerContainer/Layer0")
	if auto_input_parent:
		for node in auto_input_parent.get_children():
			if node.get_script() == preload("res://scenes/gameScene/nodes/autoInputNode/AutoInputNode.gd"):
				node.apply_income_multiplier(income_multiplier)
				node.apply_speed(interval)
	
	var output_multiplier:float = 1.0;
	for i in range(3, 0, -1):
		if upgrades["OutputMultiplier" + str(i)]: 
			output_multiplier += (0.05 * i)
			break;
	output_node.apply_output_multiplier(output_multiplier)
	
	output_node.ascension_base_mult = 1 + Ascension.upgrades["Base"] * 0.01
	
	var all_upgrades_purchased = true
	for upgrade in upgrades.values():
		if not upgrade:
			all_upgrades_purchased = false
			break
	
	if all_upgrades_purchased: 
		Global.switch_scene("res://scenes/ascension/ascension.tscn")
	
	
	#ATTENTION - Add later implemented upgrades


func _on_save_and_exit_to_os_pressed() -> void:
	pass # Replace with function body.
