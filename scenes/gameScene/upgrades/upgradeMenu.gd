extends Control

@onready var panel = $Panel

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

#ATTENTION - DELETE VARS LATER, FOR DEBUG PURPOSES ONLY
var upgrade_cost:int = 10
var upgrade_level:int = 0
#ATTENTION - NEEDS FURTHER IMPLEMENTATION
func buy_upgrade(button: Button):
	
	Sound.play_button_click()
	
	if button.has_meta("name"):
		
		var game_scene = get_tree().root.get_node("GameScene")
		
		#IMPLEMENT LATER
		#get cost and level by metadata string
		
		if game_scene.score >= upgrade_cost:
			game_scene.score -= upgrade_cost
			upgrade_cost = round(upgrade_cost * 1.5) #increase upgrade price
			upgrade_level += 1 #upgrade level
			button.text = "{0} ({1}) | cost: {2}".format([button.get_meta("name"), upgrade_level, upgrade_cost])
		

func show_tooltip(button: Button): #shows tooltip by obtaining metadata from the specific button
	if button.has_meta("tooltip_text"):
		tooltip_text = button.get_meta("tooltip_text")
		tooltip.show_tooltip(tooltip_text)
		tooltip_active = true

func hide_tooltip():
	tooltip.hide_tooltip()
	tooltip_active = false
	
