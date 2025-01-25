class_name AudioPlayer extends Node

func disturbed_sound() -> void:
	var rng = randi_range(0, 3)
	get_child(rng).play()

func dragged_sound() -> void:
	var rng = randi_range(4, 7)
	get_child(rng).play()

func walking_sound() -> void:
	var sound = get_child(8)
	if not sound.playing:
		sound.play()
