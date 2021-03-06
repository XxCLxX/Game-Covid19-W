tool
extends Button
export(String, FILE) var next_scene_path: = ""
onready var sound = $AudioStreamPlayer


func _on_MiniGameButton_button_up() -> void:
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning() -> String:
	return "next_scene_path must be set for the button to work" if next_scene_path == "" else ""


func _on_MiniGameButton_pressed() -> void:
	sound.play()
