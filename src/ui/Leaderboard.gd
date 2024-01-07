extends Panel

var sw_laderboard: Dictionary
var PlaceContainerScene = preload("res://src/ui/place_container.tscn")


func _ready():
	sw_laderboard = await SilentWolf.Scores.get_scores(5).sw_get_scores_complete

func update_scores():
	var placeholder_text = "- Your Best -"
	
	var scores = sw_laderboard["scores"]
	
	var player_highscore = GameState.highscore
	var sw_player_position = await SilentWolf.Scores.get_score_position(player_highscore).sw_get_position_complete
	var player_position = sw_player_position.position
	
	if player_position < len(scores):
		scores.insert({"score": player_highscore, "player_name": placeholder_text})
	else:
		scores.append({"score": player_highscore, "player_name": placeholder_text})
	
	for place in len(scores):
		var place_container = PlaceContainerScene.instantiate()
		%LadeboardContainer.add_child(place_container)
		%LadeboardContainer.move_child(place_container, place + 1)
		place_container.label = "%s. %s"%[place, scores[place]["player_name"]]
		place_container.score = "%s"%[scores[place]["score"]]
	
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
