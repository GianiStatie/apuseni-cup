extends Node

const PersonScene = preload("res://src/spawnables/person.tscn")
const TreeScene = preload("res://src/spawnables/tree.tscn")

var max_trees_per_row = 2
var object_spawn_x_variation = 0

func _ready():
	# TODO consider recording inputs and letting players compete with after-image
	#seed(360)
	for row_idx in range(Constants.max_rows_per_screen):
		var trees_per_row = random_sample_from_range(1, max_trees_per_row, 1)[0]
		var trees_columns = random_sample_from_range(0, Constants.max_cols_per_screen, trees_per_row)
		
		for column_idx in trees_columns:
			var tree_position = Vector2(column_idx * GameState.x_shift, row_idx * GameState.y_shift)
			_spawn_object_at(tree_position, "Tree")
	
	object_spawn_x_variation = GameState.x_shift / 2

func random_sample_from_range(from, to, ammount):
	var arr = []
	if from < 0:
		for x in range(0, abs(from)):
			arr.append(-x)
		from = 0
	arr += Array(range(from, to))
	arr.shuffle()
	
	var samples = []
	for i in range(ammount):
		samples.append(arr.pop_at(0))
	return samples

func _on_object_exited_screen_on_up(object_type):
	var row_idx = Constants.max_rows_per_screen + 1
	var column_idx = random_sample_from_range(0, Constants.max_cols_per_screen, 1)[0]
	
	var tree_position = Vector2(column_idx * GameState.x_shift, row_idx * GameState.y_shift)
	var x_variation_amount = random_sample_from_range(-object_spawn_x_variation, object_spawn_x_variation, 1)[0]
	tree_position += Vector2(x_variation_amount, 0)
	_spawn_object_at(tree_position, object_type)

func _on_object_exited_screen_on_sides(object_type, direction):
	var row_idx = random_sample_from_range(0, Constants.max_rows_per_screen, 1)[0]
	var column_idx = 0 if direction == "right" else Constants.max_cols_per_screen - 1
	
	var tree_position = Vector2(column_idx * GameState.x_shift, row_idx * GameState.y_shift)
	_spawn_object_at(tree_position, object_type)

func _spawn_object_at(tree_position, object_type):
	var object = null
	if object_type == "Tree":
		object = TreeScene.instantiate()
	elif object_type == "Person":
		object = PersonScene.instantiate()
	
	object.connect("exited_screen_on_up", _on_object_exited_screen_on_up)
	object.connect("exited_screen_on_right", _on_object_exited_screen_on_sides.bindv(["right"]))
	object.connect("exited_screen_on_left", _on_object_exited_screen_on_sides.bindv(["left"]))
	add_child(object)
	object.global_position = tree_position
