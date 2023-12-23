extends Node


func instance_scene_on_main(scene, location, init_params := {}):
	var main = get_tree().current_scene
	var instance = scene.instantiate()
	
	if init_params != {}:
		instance.init(init_params)
	
	main.add_child(instance)
	instance.global_position = location
	return instance

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
