extends Node

signal scene_loaded(new_scene, should_load)

func switch_scene(path: String, should_load: bool = false) -> void:
	var new_scene = load(path).instantiate()
	new_scene.set("should_load", should_load)
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene
