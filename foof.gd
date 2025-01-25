extends Node2D

@onready var window:Window = get_window()
@onready var viewport:Viewport = get_viewport()
@onready var area:Rect2i = DisplayServer.screen_get_usable_rect()

var stats:FoofSettings

var velocity:Vector2 = Vector2(100,100)
var movement_dir:Vector2 = Vector2(0.75, 0.75)
var target_pos:Vector2
var mouse_in:bool = false;
var dragging:bool = false;

@export var pull_strength:float = 400

@export var audio_player: AudioPlayer

# Sprites
var i = 1
var texture1 = load("res://Sprites/foof1.png")
var texture2 = load("res://Sprites/foof2.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	window.mouse_entered.connect(_on_mouse_entered)
	window.mouse_exited.connect(_on_mouse_exited)
	
	print(area)
	OS.alert("It's a foof owo", "Foof Alert")
	window.always_on_top = true
	
	stats = ResourceLoader.load("res://DEFAULT.tres") as FoofSettings

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	area = DisplayServer.screen_get_usable_rect()
	
	target_pos += velocity * delta
	window.position = Vector2i(target_pos)
	velocity *= 1-(stats.drag * delta)
	
	if stats.borders:
		if window.position.x < area.position.x and velocity.x < 0: 
			velocity.x *= -1
			if abs(velocity.x) > 200: $"Bounce SFX1".play()
		if window.position.y < area.position.y and velocity.y < 0: 
			velocity.y *= -1
			if abs(velocity.y) > 200: $"Bounce SFX2".play()
		if (window.position.x  + window.size.x) > area.end.x and velocity.x > 0: 
			velocity.x *= -1
			if abs(velocity.x) > 200: $"Bounce SFX3".play()
		if (window.position.y + window.size.y) > area.end.y and velocity.y > 0: 
			velocity.y *= -1
			if abs(velocity.y) > 200: $"Bounce SFX4".play()
	
	if dragging:
		var pos_delta:Vector2 = DisplayServer.mouse_get_position() - (window.position + window.size/2)
		velocity += ((pull_strength * abs(pos_delta).normalized()) * pos_delta) * delta
	
	## Launch the foof slightly.
	if Input.is_action_just_pressed("click") and mouse_in:
		velocity += Vector2.UP * stats.click_force
		audio_player.disturbed_sound()
	
	## Drag the foof. Might need a invisible "cursor-bound" window for seing the release trigger
	if Input.is_action_just_pressed("click2") and mouse_in: dragging = true
	if Input.is_action_just_released("click2") and dragging: dragging = false
	
	if mouse_in:
		if Input.is_action_just_pressed("wheelDown"): $Sprite2D.rotation_degrees += 22.5
		if Input.is_action_just_pressed("wheelUp"): $Sprite2D.rotation_degrees -= 22.5


func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited():
	mouse_in = false;


func _on_move_timer_timeout():
	if $MoveTimer.is_stopped(): 
		$MoveTimer.start(stats.step_timer + randf_range(-stats.step_randomnes, stats.step_randomnes))
	
	var k:float = 1
	if mouse_in: k = 0.15
	
	movement_dir = DisplayServer.mouse_get_position() - (window.position + window.size/2)
	velocity += movement_dir.normalized() * stats.step_force * k
	
	if not dragging: audio_player.walking_sound()
	switch_sprite()
	flip_sprite()


# Sprite Stuff
func flip_sprite() -> void:
	if $Sprite2D.flip_h and window.position.x < DisplayServer.mouse_get_position().x:
		$Sprite2D.flip_h = false
	elif not $Sprite2D.flip_h and window.position.x > DisplayServer.mouse_get_position().x:
		$Sprite2D.flip_h = true


func switch_sprite() -> void:
	if i >= 2: i = 1
	else: i += 1
	
	match i:
		1: $Sprite2D.texture = texture1
		2: $Sprite2D.texture = texture2
