extends VideoPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_Introscene_finished() -> void:
	get_tree().change_scene("res://src/Screens/MainScreen.tscn")
