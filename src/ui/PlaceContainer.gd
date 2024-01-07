extends HBoxContainer

var label = null : set = _set_label, get = _get_label
var score = null : set = _set_score, get = _get_score

func _set_label(text):
	%PlaceLabel.text = str(text)

func _get_label():
	return %PlaceLabel.text

func _set_score(text):
	%PlaceScore.text = str(text)

func _get_score():
	return %PlaceScore.text
