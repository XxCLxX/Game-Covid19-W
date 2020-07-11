extends Node2D

var score = 0

func _on_Coin_coin_collected():
	score = score + 1
	var scoretext = "Score: "+String(score)
	print(scoretext)
