extends Node2D

@onready var progress_bar = %ProgressBar
@onready var speed_label = %SpeedLabel
@onready var end_screen = %EndScreen

@onready var main_theme = $MainTheme
@onready var celebration = $Celebration
@onready var spawner = $Spawner

var distance = 0
var max_player_speed = 0
var accelerate_player = false

var main_theme_time = 3
var main_theme_total_time = 2 * 60 + 32
var spawned_end_screen = false

func _ready():
	progress_bar.max_value = main_theme_total_time
	
	if GameState.seen_tutorial:
		_on_tutorial_button_button_down()

func _input(event):
	if event.is_action_pressed("ui_accept") and %TutorialScreen.visible:
		_on_tutorial_button_button_down()
	if event.is_action_pressed("ui_cancel"):
		_on_pause_button_pressed()

func _process(_delta):
	if GameState.game_paused:
		return
	
	var player_speed = GameState.move_speed_y / 1000.0 * 2
	max_player_speed = max(max_player_speed, player_speed)
	speed_label.text = "%.2f mps"%player_speed
	
	distance += GameState.move_speed_y / 1e4 
	main_theme_time = main_theme.get_playback_position()
	progress_bar.value = main_theme_time
	
	if main_theme_time >= main_theme_total_time - 2 and not spawned_end_screen:
		spawner.spawn_object_at_end("RaceEnd")
		spawned_end_screen = true
	
	if main_theme_time >= main_theme_total_time:
		celebration.play(1)
		_on_player_player_hit_obstacle()
	
	if accelerate_player and int(GameState.total_time * 10) % 10 == 0:
		GameState.move_speed_y += GameState.acceleartion

func _on_pause_button_pressed():
	if not GameState.game_started or GameState.game_over:
		return
	
	if not GameState.game_paused:
		main_theme.stop()
		GameState.game_paused = true
		%PauseScreen.visible = true
	else:
		_on_resume_pressed()

func _on_player_player_hit_obstacle():
	GameState.completion = (main_theme_time / main_theme_total_time) * 100
	GameState.max_player_speed = max_player_speed
	GameState.total_distance = distance
	
	GameState.game_paused = true
	GameState.game_over = true
	
	main_theme.stop()
	end_screen._on_game_over()

func _on_player_player_started_game():
	for timer in $Timers.get_children():
		timer.start()
	
	main_theme.play(main_theme_time)
	GameState.game_started = true

func _on_tutorial_button_button_down():
	GameState.seen_tutorial = true
	%TutorialScreen.visible = false
	%Time.visible = true

func _on_resume_pressed():
	main_theme.play(main_theme_time)
	GameState.game_paused = false
	%PauseScreen.visible = false

func _on_restart_pressed():
	GameState._on_reset_button_pressed()

func show_warning(text):
	%Warning.text = text
	%Warning.get_node("AnimationPlayer").play("Show")

func _on_level_1_timeout():
	if GameState.game_over:
		return
	accelerate_player = true
	show_warning("The Slope Steepens")

func _on_level_2_timeout():
	if GameState.game_over:
		return
	GameState.acceleartion += 5
	show_warning("The Slope Steepens")

func _on_ramp_spawner_timeout():
	if GameState.game_over:
		return
	spawner.spawn_object_at_end("Ramp", true)
	$Timers/RampSpawner.start()
