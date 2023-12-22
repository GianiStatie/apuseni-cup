extends Node2D

@onready var progress_bar = %ProgressBar
@onready var time_label = %Time
@onready var timer = $Timer

var distance = 0
var emplased_time = 0


func _process(_delta):
	if GameState.game_paused:
		return
	
	distance += GameState.move_speed_y / 1e4 
	progress_bar.value = distance

func _on_player_started_game():
	time_label.text = "Your time: %ss"%(emplased_time)
	timer.start()

func _on_timer_timeout():
	emplased_time += 1
	time_label.text = "Your time: %ss"%(emplased_time)
	timer.start()
