extends Node2D

@onready var window:Window = get_window()
@onready var viewport:Viewport = get_viewport()
@onready var area:Rect2i = DisplayServer.screen_get_usable_rect()

var stats:FoofSettings

var velocity:Vector2 = Vector2(100,100)
var movement_dir:Vector2 = Vector2(0.75, 0.75)
var target_pos:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	window.close_requested.connect(_on_close_requested)
	window.mouse_entered.connect(_on_mouse_entered)
	window.mouse_exited.connect(_on_mouse_exited)
	
	print(area)
	OS.alert("It's a foof owo", "Foof Alert")
	window.always_on_top = true
	
	stats = ResourceLoader.load("res://DEFAULT.tres") as FoofSettings

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	target_pos += velocity * delta
	window.position = Vector2i(target_pos)
	velocity *= 1-(stats.drag * delta)
	
	if window.position.x < area.position.x and velocity.x < 0: velocity.x *= -1
	if window.position.y < area.position.y and velocity.y: velocity.y *= -1
	if (window.position.x  + window.size.x) > area.end.x and velocity.x > 0: velocity.x *= -1
	if (window.position.y + window.size.y) > area.end.y and velocity.y > 0: velocity.y *= -1
	
	
	## If there is any image in his clippboard, render on his hand? Swap with something in his hand?
	## override what is in clippboard into his hand? 
	## Revert back on close?
	if DisplayServer.clipboard_has_image():
		pass
	
	area = DisplayServer.screen_get_usable_rect()
	
	## Launch the foof slightly. +1dmg
	if Input.is_action_just_pressed("click"):
		velocity += Vector2.UP * stats.click_force
		
	elif Input.is_action_just_released("click"):
		pass
	
	## Drag the foof. Might need a invisible "cursor-bound" window for seing the release trigger
	elif Input.is_action_just_pressed("click2"):
		pass
	elif Input.is_action_just_released("click2"):
		pass
	
	## makes him spin? becomes weaker? stronger?
	elif Input.is_action_just_pressed("wheelDown"):
		pass


## If steal clipboard thing... return on close...
func _on_close_requested():
	DisplayServer.CursorShape

func _on_mouse_entered():
	print("mouse entered")

func _on_mouse_exited():
	print("mouse exited")


func _on_move_timer_timeout():
	if $MoveTimer.is_stopped(): 
		$MoveTimer.start(stats.step_timer + randf_range(-stats.step_randomnes, stats.step_randomnes))
	
	movement_dir = DisplayServer.mouse_get_position() - (window.position + window.size/2)
	velocity += movement_dir.normalized() * stats.step_force
	
	
