extends Node2D

const PersonScene = preload("res://src/spawnables/person.tscn")
const TreeScene = preload("res://src/spawnables/tree.tscn")

var max_trees_per_row = 2
var object_spawn_x_variation = 0

var nb_of_trees = 4
var nb_of_people = 4


func _ready():
	# TODO consider recording inputs and letting players compete with after-image
	#seed(360)
	spawn_objects(nb_of_trees, "Tree", 3)
	spawn_objects(nb_of_people, "Person", 3)
	
	object_spawn_x_variation = GameState.x_shift / 2

func _on_object_exited_screen_on_up(object_type):
	var row_idx = Constants.max_rows_per_screen + 1
	var column_idx = Utils.random_sample_from_range(0, Constants.max_cols_per_screen, 1)[0]
	
	var tree_position = Vector2(column_idx * GameState.x_shift, row_idx * GameState.y_shift)
	var x_variation_amount = Utils.random_sample_from_range(-object_spawn_x_variation, object_spawn_x_variation, 1)[0]
	tree_position += Vector2(x_variation_amount, 0)
	_spawn_object_at(tree_position, object_type)

func _on_object_exited_screen_on_sides(object_type, direction):
	var row_idx = Utils.random_sample_from_range(0, Constants.max_rows_per_screen, 1)[0]
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

func spawn_objects(nb_of_objects, object_type, min_row):
	var trees_per_row = int(nb_of_objects / Constants.max_rows_per_screen)
	for row_idx in range(min_row, Constants.max_rows_per_screen):
		var trees_columns = Utils.random_sample_from_range(0, Constants.max_cols_per_screen, trees_per_row)
		
		for column_idx in trees_columns:
			var tree_position = Vector2(column_idx * GameState.x_shift, row_idx * GameState.y_shift)
			_spawn_object_at(tree_position, object_type)
	
	var trees_left = nb_of_objects % Constants.max_rows_per_screen
	var random_rows = Utils.random_sample_from_range(min_row, Constants.max_rows_per_screen, trees_left)
	for row_idx in random_rows:
		var trees_columns = Utils.random_sample_from_range(0, Constants.max_cols_per_screen, 1)
		
		for column_idx in trees_columns:
			var tree_position = Vector2(column_idx * GameState.x_shift, row_idx * GameState.y_shift)
			_spawn_object_at(tree_position, object_type)
