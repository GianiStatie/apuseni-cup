extends Node2D


func _ready():
	global_position = GameState.player_position - Vector2(0, 128)

func _process(delta):
	if GameState.game_paused:
		return
	
	var move_speed = Vector2(GameState.move_speed_x, GameState.move_speed_y)
	position -= move_speed * delta
	
	if position.y < -300:
		queue_free()
