extends Node2D

@onready var window:Window = get_window()
@onready var viewport:Viewport = get_viewport()

# Called when the node enters the scene tree for the first time.
func _ready():
	window.close_requested.connect(_on_close_requested)
	window.mouse_entered.connect(_on_mouse_entered)
	window.mouse_exited.connect(_on_mouse_exited)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	window.position.x += 1
	OS
	
	
	## If there is any image in his clippboard, render on his hand? Swap with something in his hand?
	## override what is in clippboard into his hand? 
	## Revert back on close?
	if DisplayServer.clipboard_has_image():
		pass


## If steal clipboard thing... return on close...
func _on_close_requested():
	pass

func _on_mouse_entered():
	pass

func _on_mouse_exited():
	pass
