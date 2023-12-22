extends Node2D

@onready var progress_bar = %ProgressBar
@onready var speed_label = %SpeedLabel
@onready var end_screen = %EndScreen
@onready var max_distance = progress_bar.max_value

var distance = 0
var max_player_speed = 0

func _process(_delta):
	if GameState.game_paused:
		return
	
	var player_speed = GameState.move_speed_y / 1000.0 * 2
	max_player_speed = max(max_player_speed, player_speed)
	speed_label.text = "%.2f mps"%player_speed
	
	distance += GameState.move_speed_y / 1e4 
	progress_bar.value = distance
	
	if distance == max_distance:
		_on_player_player_hit_obstacle()

func _on_player_player_hit_obstacle():
	GameState.completion = (distance / max_distance) * 100
	GameState.max_player_speed = max_player_speed
	GameState.total_distance = distance
	
	GameState.game_paused = true
	GameState.game_over = true
	
	end_screen._on_game_over()
