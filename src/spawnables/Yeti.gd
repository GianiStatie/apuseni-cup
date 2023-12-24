extends Area2D

var margin_px = 25


func _process(delta):
	if GameState.game_paused:
		return
	
	var move_speed = Vector2(GameState.move_speed_x, GameState.move_speed_y)
	position -= move_speed * delta
	
	var player_position = Vector2(GameState.player_x, GameState.player_y)
	var yeti_speed = max(GameState.move_speed_y * 0.95, 850)
	position = position.move_toward(player_position, delta * yeti_speed)

func _on_area_entered(area):
	$Sprite2D.visible = false
	$Sprite2D2.visible = true
