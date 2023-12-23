extends CenterContainer


func _on_visibility_changed():
	if visible:
		$VBoxContainer/HighScore.text = str(GameState.highscore)
