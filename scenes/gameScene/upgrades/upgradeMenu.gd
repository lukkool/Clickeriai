extends Control

@onready var panel = $Panel
@onready var game_scene = get_tree().root.get_node("GameScene")


func _toggle_panel() -> void:
	panel.visible = !panel.visible
	Sound.play_button_click()

@onready var tooltip = $Tooltip
var tooltip_active = false

func _ready():
	for button in get_tree().get_nodes_in_group("upgrade_buttons"): #automatically connects upgrade buttons
		button.mouse_entered.connect(func(): show_tooltip(button))
		button.mouse_exited.connect(hide_tooltip)
		button.pressed.connect(func(): buy_upgrade(button))

func _process(_delta):
	if tooltip_active: #keeps tooltip on the mouse position
		tooltip.global_position = get_global_mouse_position() + Vector2(20, 10)
		
	update_upgrade_buttons()

func buy_upgrade(button: Button):
	
	Sound.play_button_click()
	var upgrade_cost:float
	var upgrade_name = button.get_meta("name")
	var upgrade_level = int(game_scene.upgrades.get(upgrade_name, 0))
	if button.get_meta("SinglePurchace"): 
		upgrade_cost = button.get_meta("BasePrice")
	else:
		upgrade_cost = (
			button.get_meta("BasePrice") * 
			button.get_meta("PriceGrowthRate") **
			upgrade_level
		)
	
	if game_scene.score >= upgrade_cost:
		game_scene.score -= upgrade_cost
		
		if button.get_meta("SinglePurchace"):
			game_scene.upgrades[button.get_meta("name")] = true
			button.queue_free()
		else:
			upgrade_level += 1
			game_scene.upgrades[upgrade_name] = upgrade_level
			
			var next_cost = button.get_meta("BasePrice") * button.get_meta("PriceGrowthRate") ** upgrade_level
			button.text = "{0} ({1}) | cost: {2}".format([upgrade_name, upgrade_level, next_cost])
		
		game_scene.update_upgrades()
		
				
func show_tooltip(button: Button): #shows tooltip by obtaining metadata from the specific button
	if button.has_meta("tooltip_text"):
		tooltip_text = button.get_meta("tooltip_text")
		tooltip.show_tooltip(tooltip_text)
		tooltip_active = true

func update_upgrade_buttons():
	
	var manual_upgrade_name = "ManualInputUpgrade"
	var manual_button = get_node("Panel/ScrollContainer/VBoxContainer/ManualInputUpgrade")
	var manual_level = game_scene.upgrades.get(manual_upgrade_name, 0)
	var base_price = manual_button.get_meta("BasePrice")
	var price_growth = manual_button.get_meta("PriceGrowthRate")

	var manual_upgrade_cost = base_price * price_growth ** manual_level
	
	manual_button.text = "%s (Level %d) | Cost: %.1f" % ["Manual Input", manual_level, manual_upgrade_cost]
	manual_button.visible = true
	manual_button.disabled = game_scene.score < manual_upgrade_cost


	var autoInputUnlocked:bool = false
	var unlockDense:bool = false
	var unlockConvolutional:bool = false
	var unlockReccurent:bool = false
	
	for i in range(4, 0, -1):
		if game_scene.upgrades["AutoInputNode" + str(i)]:
			autoInputUnlocked = true
			if i == 4:
				break
			else:
				get_node("Panel/ScrollContainer/VBoxContainer/AutoNode" + str(i + 1)).visible = true
				break
		if i == 1:
			get_node("Panel/ScrollContainer/VBoxContainer/AutoNode" + str(i)).visible = true
			
	if autoInputUnlocked:
		for i in range(3, 0, -1):
			if game_scene.upgrades["AutoSpeed" + str(i)]:
				if i == 3:
					break
				else:
					get_node("Panel/ScrollContainer/VBoxContainer/AutoSpeed" + str(i + 1)).visible = true
					break
			if i == 1:
				get_node("Panel/ScrollContainer/VBoxContainer/AutoSpeed" + str(i)).visible = true
				
		if !game_scene.upgrades["AutoInputIncomeDouble"]:
			get_node("Panel/ScrollContainer/VBoxContainer/Panel_VBoxContainer#AutoInputIncomeDouble").visible = true
			
	for i in range(6, 0, -1):
		if game_scene.upgrades["BatchNormalizationNode" + str(i)]:
			unlockDense = true
			if i == 6:
				break
			else:
				get_node("Panel/ScrollContainer/VBoxContainer/BatchNormalizationNode" + str(i + 1)).visible = true
				break
		if i == 1:
			get_node("Panel/ScrollContainer/VBoxContainer/BatchNormalizationNode" + str(i)).visible = true
			
	if unlockDense:
		for i in range(6, 0, -1):
			if game_scene.upgrades["DenseNode" + str(i)]:
				unlockConvolutional = true
				if i == 6:
					break
				else:
					get_node("Panel/ScrollContainer/VBoxContainer/DenseNode" + str(i + 1)).visible = true
					break
			if i == 1:
				get_node("Panel/ScrollContainer/VBoxContainer/DenseNode" + str(i)).visible = true
		
	if unlockConvolutional:
		for i in range(6, 0, -1):
			if game_scene.upgrades["ConvolutionalNode" + str(i)]:
				unlockReccurent = true
				if i == 6:
					break
				else:
					get_node("Panel/ScrollContainer/VBoxContainer/ConvolutionalNode" + str(i + 1)).visible = true
					break
			if i == 1:
				get_node("Panel/ScrollContainer/VBoxContainer/ConvolutionalNode" + str(i)).visible = true
				
	if unlockReccurent:
		for i in range(6, 0, -1):
			if game_scene.upgrades["RecurrentNode" + str(i)]:
				if i == 6:
					break
				else:
					get_node("Panel/ScrollContainer/VBoxContainer/RecurrentNode" + str(i + 1)).visible = true
					break
			if i == 1:
				get_node("Panel/ScrollContainer/VBoxContainer/RecurrentNode" + str(i)).visible = true
	
	for i in range(3, 0, -1):
		if game_scene.upgrades["OutputMultiplier" + str(i)]:
			if i == 3:
				break
			else:
				get_node("Panel/ScrollContainer/VBoxContainer/OutputMultiplier" + str(i + 1)).visible = true
				break
		if i == 1:
			get_node("Panel/ScrollContainer/VBoxContainer/OutputMultiplier" + str(i)).visible = true

	if not game_scene.upgrades["ManualInputMultiplier"]:
		get_node("Panel/ScrollContainer/VBoxContainer/ManualInputMultiplier").visible = true
		
func hide_tooltip():
	tooltip.hide_tooltip()
	tooltip_active = false
	
