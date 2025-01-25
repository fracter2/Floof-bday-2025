class_name AudioPlayer extends Node

func play_sound() -> void:
	assert("Playing sound")
	var rng = randi_range(0, 5)
	match rng:
		0: get_child(0).play()
		1: get_child(1).play()
		2: get_child(2).play()
		3: get_child(3).play()
		4: get_child(4).play()
		5: get_child(5).play()
