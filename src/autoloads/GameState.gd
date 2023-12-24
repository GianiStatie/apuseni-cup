extends Node

var min_speed_y = 10
var max_speed_y = 1000

var strife_perc = 0.5

var seen_tutorial = false
var highscore = 0
var attempts = 1

var acceleartion = 5
var deceleration = 10

var move_speed_x = 0
var move_speed_y = 20
var game_started = false
var game_paused = true
var game_over = false

var total_distance = 0
var total_time = 0
var completion = 0
var max_player_speed = 0
var bonus_points = 0

@onready var viewport_size = get_viewport().size
@onready var x_shift = viewport_size.x / (Constants.max_cols_per_screen - 1)
@onready var y_shift = viewport_size.y / (Constants.max_rows_per_screen - 1)

@onready var player_x = (Constants.max_cols_per_screen - 1) * x_shift / 2
@onready var player_y = (Constants.max_rows_per_screen - 1) * y_shift / 3 

func _on_reset_button_pressed():
	attempts += 1
	reset_state()
	get_tree().reload_current_scene()

func reset_state():
	acceleartion = 5
	deceleration = 10
	
	total_distance = 0
	total_time = 0
	completion = 0
	max_player_speed = 0
	bonus_points = 0
	
	game_started = false
	game_paused = true
	game_over = false
	move_speed_y = 20
