extends Control


func _on_button_ascend_pressed():
	Ascension.upgrades["Base"] += 1
	await get_tree().change_scene_to_file("res://scenes/gameScene/gameScene.tscn")
	
	
	
