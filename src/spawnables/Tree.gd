extends Area2D

var margin_px = 32
var on_screen = true

signal exited_screen_on_up(main_group)
signal exited_screen_on_left(main_group)
signal exited_screen_on_right(main_group)

func _ready():
	var variations = $Variations.get_children()
	variations.shuffle()
	variations[0].visible = true

func _process(delta):
	if GameState.game_paused:
		return
	position -= Vector2(GameState.move_speed_x, GameState.move_speed_y) * delta
	
	if global_position.y < -margin_px:
		_on_exited_viewport_vertically()
	
	if on_screen and global_position.x < -margin_px:
		emit_signal("exited_screen_on_left", get_groups()[0])
		queue_free()

	if on_screen and global_position.x > GameState.viewport_size.x + margin_px:
		emit_signal("exited_screen_on_right", get_groups()[0])
		queue_free()

func _on_exited_viewport_vertically():
	emit_signal("exited_screen_on_up", get_groups()[0])
	queue_free()
