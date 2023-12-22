extends Label

var time = 0


func _process(delta):
	if GameState.game_paused:
		return
	
	time += delta
	var mils = fmod(time, 1) * 1000
	var secs = fmod(time, 60)
	var mins = fmod(time, 60*60) / 60
	
	var time_passed = "%02d : %02d : %03d" % [mins, secs, mils]
	text = time_passed
	
	GameState.total_time = time
