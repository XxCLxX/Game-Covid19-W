extends Button
onready var sound = $AudioStreamPlayer


func _on_button_up():
	get_tree().quit()

func _on_QuitButton_pressed() -> void:
	sound.play()
