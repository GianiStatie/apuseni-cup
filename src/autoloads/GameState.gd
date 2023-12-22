extends Node

var min_speed_y = 10
var max_speed_y = 1500

var seen_tutorial = false
var highscore = 0

var move_speed_x = 0
var move_speed_y = 20
var game_paused = true
var game_over = false

var total_distance = 0
var total_time = 0
var completion = 0
var max_player_speed = 0

@onready var viewport_size = get_viewport().size
@onready var x_shift = viewport_size.x / (Constants.max_cols_per_screen - 1)
@onready var y_shift = viewport_size.y / (Constants.max_rows_per_screen - 1)

func _on_reset_button_pressed():
	reset_state()
	get_tree().reload_current_scene()

func reset_state():
	total_distance = 0
	total_time = 0
	completion = 0
	max_player_speed = 0
	
	game_paused = true
	game_over = false
	move_speed_y = 20
