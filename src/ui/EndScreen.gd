extends Panel


func _on_game_over():
	visible = true
	
	var score = int(Constants.max_score * GameState.completion / 10 / GameState.total_time)
	%ScoreLabel.text = str(score)
	
	%DistanceLabel.text = "%0.2f"%GameState.total_distance
	%TotalTimeLabel.text = "%0.2f"%GameState.total_time
	%MaxSpeedLabel.text = "%0.2f"%GameState.max_player_speed

func _on_button_button_down():
	GameState._on_reset_button_pressed()
