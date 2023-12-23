extends Node2D

const MAX_POINTS: int = 100
var past_locations = []
var is_stopped = false

func _process(delta):
	if GameState.game_over:
		return
	
	for point_idx in len(past_locations):
		past_locations[point_idx] -= Vector2(GameState.move_speed_x, GameState.move_speed_y) * delta
	
	if !is_stopped:
		if len(past_locations) > MAX_POINTS:
			past_locations.pop_at(0)
		past_locations.append(Vector2.ZERO)
	
	$TrailLeft.points = past_locations
	$TrailRight.points = past_locations

func stop():
	is_stopped = true
