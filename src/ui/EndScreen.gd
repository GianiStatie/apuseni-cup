extends Panel


func _input(event):
	if event.is_action_pressed("ui_accept") and GameState.game_over:
		GameState._on_reset_button_pressed()

func _on_game_over():
	visible = true
	
	var score = int(Constants.max_score * GameState.completion / 100 - GameState.total_time)
	
	if GameState.highscore < score:
		GameState.highscore = score
		%HighScoreLabel.visible = true
	else:
		%HighScoreLabel.visible = false
	
	%ScoreLabel.text = str(score)
	
	%DistanceLabel.text = "%0.2f"%GameState.total_distance
	%TotalTimeLabel.text = "%0.2f"%GameState.total_time
	%MaxSpeedLabel.text = "%0.2f"%GameState.max_player_speed

func _on_button_button_down():
	GameState._on_reset_button_pressed()
