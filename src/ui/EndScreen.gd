extends Panel


func _input(event):
	if event.is_action_pressed("ui_accept") and GameState.game_over:
		GameState._on_reset_button_pressed()

func _on_game_over():
	visible = true
	
	var score = int(Constants.max_score * GameState.completion * GameState.total_distance / 10000) + GameState.bonus_points
	
	if GameState.highscore < score:
		GameState.highscore = score
		%HighScoreLabel.visible = true
	else:
		%HighScoreLabel.visible = false
	
	%ScoreLabel.text = str(score)
	
	%DistanceLabel.text = "%0.2f"%GameState.total_distance
	%MaxSpeedLabel.text = "%0.2f"%GameState.max_player_speed
	%AttemptsLabel.text = "%s"%GameState.attempts

func _on_button_button_down():
	GameState._on_reset_button_pressed()
