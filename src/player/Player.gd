extends Area2D

var should_accelearte = false
var should_decelerate = false

var strife_left = false
var strife_right = false
var is_jumping = false


@onready var sprite_stop = $SpriteStop
@onready var sprite_move = $SpriteMove
@onready var oof_sound = $OofSoundEffect
@onready var animation_player = $AnimationPlayer

signal player_started_game
signal player_hit_obstacle


func _input(event):
	if not GameState.seen_tutorial or GameState.game_over:
		return
	
	if event.is_action_pressed("ui_down"):
		should_accelearte = true
	elif event.is_action_released("ui_down"):
		should_accelearte = false
	elif event.is_action_pressed("ui_up"):
		should_decelerate = true
	elif event.is_action_released("ui_up"):
		should_decelerate = false
	
	if event.is_action_pressed("ui_left"):
		strife_left = true
	elif event.is_action_released("ui_left"):
		strife_left = false
	
	if event.is_action_pressed("ui_right"):
		strife_right = true
	elif event.is_action_released("ui_right"):
		strife_right = false
	
	if event.is_action_pressed("ui_accept"):
		if not is_jumping and GameState.move_speed_y > 100:
			is_jumping = true
			animation_player.play("Jumping")
	
	if GameState.game_paused and should_accelearte:
		player_started_game.emit()
		GameState.game_paused = false

func _process(_delta):
	if GameState.game_paused:
		return
	
	if strife_right == strife_left:
		GameState.move_speed_x = 0
	else:
		var srtife_speed = GameState.strife_perc * GameState.move_speed_y
		GameState.move_speed_x = -srtife_speed if strife_left else srtife_speed
	 
	if is_jumping:
		return
	
	if GameState.move_speed_y <= GameState.min_speed_y:
		sprite_move.visible = false
	else:
		sprite_move.visible = true
	
	if should_accelearte and GameState.move_speed_y < GameState.max_speed_y:
		GameState.move_speed_y += GameState.acceleartion
	if should_decelerate and GameState.move_speed_y > GameState.min_speed_y:
		GameState.move_speed_y -= GameState.deceleration

func _on_area_entered(_area):
	if not GameState.game_over:
		GameState.move_speed_x = 0
		oof_sound.play(0.2)
		player_hit_obstacle.emit()

func _on_finished_jumping():
	is_jumping = false
