class_name AudioPlayer extends Node

func play_sound() -> void:
	var rng = randi_range(0, 8)
	get_child(rng).play()
