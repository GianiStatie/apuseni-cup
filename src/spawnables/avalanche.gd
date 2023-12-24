extends Area2D

var initial_speed = 200
var max_speed = 650

func _process(delta):
	if GameState.game_paused:
		return
	
	var move_speed = Vector2(GameState.move_speed_x, GameState.move_speed_y)
	position -= move_speed * delta
	
	var player_position = Vector2(GameState.player_x, GameState.player_y)
	
	initial_speed = move_toward(initial_speed, max_speed, 1)
	var yeti_speed = max(GameState.move_speed_y * 0.95, initial_speed)
	position = position.move_toward(player_position, delta * yeti_speed)


func _on_area_entered(area):
	$Sprite2D.visible = false
	$Sprite2D2.visible = true
 
