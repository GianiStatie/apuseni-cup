extends Node2D


func _process(delta):
	if GameState.game_paused:
		return
	
	var move_speed = Vector2(GameState.move_speed_x, GameState.move_speed_y)
	position -= move_speed * delta
