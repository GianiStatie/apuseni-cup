extends Node

var min_speed_y = 10
var max_speed_y = 1500

var move_speed_x = 0
var move_speed_y = 420
var game_paused = true

@onready var viewport_size = get_viewport().size
@onready var x_shift = viewport_size.x / (Constants.max_cols_per_screen - 1)
@onready var y_shift = viewport_size.y / (Constants.max_rows_per_screen - 1)
