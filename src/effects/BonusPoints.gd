extends Marker2D


func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(), 1)
	tween.tween_callback(self.queue_free)
