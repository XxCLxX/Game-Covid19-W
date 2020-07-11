extends Area2D

signal coin_collected
export var score:= 10

func _on_Coin_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("coin_collected")
		queue_free() 
		picked()
		
		
func picked() -> void:
	PlayerData.score += score

