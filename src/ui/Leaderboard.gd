extends Panel


func update_scores():
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(5).sw_get_scores_complete
	
	%FirstPlaceLabel.text = "1. %s"%(sw_result["scores"][0]["player_name"])
	%FirstPlaceScore.text = "%s"%(sw_result["scores"][0]["score"])
	
	%SecondPlaceLabel.text = "2. %s"%(sw_result["scores"][1]["player_name"])
	%SecondPlaceScore.text = "%s"%(sw_result["scores"][1]["score"])
	
	%ThirdPlaceLabel.text = "3. %s"%(sw_result["scores"][2]["player_name"])
	%ThirdPlaceScore.text = "%s"%(sw_result["scores"][2]["score"])
	
	%FourthPlaceLabel.text = "4. %s"%(sw_result["scores"][3]["player_name"])
	%FourthPlaceScore.text = "%s"%(sw_result["scores"][3]["score"])
	
	%FifthPlaceLabel.text = "5. %s"%(sw_result["scores"][4]["player_name"])
	%FifthPlaceScore.text = "%s"%(sw_result["scores"][4]["score"])
	
	%YourPlaceScore.text = "%s"%(GameState.highscore)
	
	if GameState.highscore_submitted:
		%SubmitContainer.visible = false
		%AlreadySubmitted.visible = true

func _on_submit_pressed():
	var metadata = {
		"total_distance": GameState.total_distance,
		"total_time": GameState.total_time,
		"completion": GameState.completion,
		"max_player_speed": GameState.max_player_speed,
		"bonus_points": GameState.bonus_points,
		"attempts": GameState.attempts
		}
	SilentWolf.Scores.save_score(%PlayerName.text, GameState.highscore, "main", metadata)
	GameState.highscore_submitted = true
	GameState._on_reset_button_pressed()

func _on_player_name_text_changed(new_text):
	var player_name = %PlayerName.text
	
	if player_name != "" and BadWordsFilter.is_word_ok(player_name) and not GameState.highscore_submitted:
		%SubmitButton.disabled = false
	else:
		%SubmitButton.disabled = true

func _on_retry_pressed():
	GameState._on_reset_button_pressed()
