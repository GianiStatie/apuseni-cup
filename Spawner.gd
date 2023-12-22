extends Node

const TreeScene = preload("res://spawnables/tree.tscn")

var max_trees_per_row = 2

func _ready():
	# TODO consider recording inputs and letting players compete with other players after-image
	#seed(360)
	
	for row_idx in range(Constants.max_rows_per_screen):
		var trees_per_row = random_sample_from_range(1, max_trees_per_row, 1)[0]
		var trees_columns = random_sample_from_range(0, Constants.max_cols_per_screen, trees_per_row)
		
		for column_idx in trees_columns:
			var tree_position = Vector2(column_idx * GameState.x_shift, row_idx * GameState.y_shift)
			_spawn_tree_at(tree_position)

func random_sample_from_range(from, to, ammount):
	var arr = Array(range(from, to))
	arr.shuffle()
	
	var samples = []
	for i in range(ammount):
		samples.append(arr.pop_at(0))
	return samples

func _on_object_exited_screen_on_up():
	var row_idx = Constants.max_rows_per_screen + 1
	var column_idx = random_sample_from_range(0, Constants.max_cols_per_screen, 1)[0]
	
	var tree_position = Vector2(column_idx * GameState.x_shift, row_idx * GameState.y_shift)
	_spawn_tree_at(tree_position)

func _on_object_exited_screen_on_sides(direction):
	# TODO: check cell is not occupied when spawning
	var row_idx = random_sample_from_range(0, Constants.max_rows_per_screen, 1)[0]
	var column_idx = 0 if direction == "right" else Constants.max_cols_per_screen - 1
	
	var tree_position = Vector2(column_idx * GameState.x_shift, row_idx * GameState.y_shift)
	_spawn_tree_at(tree_position)

func _spawn_tree_at(tree_position):
	var tree_object = TreeScene.instantiate()
	tree_object.connect("exited_screen_on_up", _on_object_exited_screen_on_up)
	tree_object.connect("exited_screen_on_right", _on_object_exited_screen_on_sides.bind("right"))
	tree_object.connect("exited_screen_on_left", _on_object_exited_screen_on_sides.bind("left"))
	add_child(tree_object)
	tree_object.global_position = tree_position
