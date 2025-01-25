extends Resource
class_name FoofSettings

## Movement
@export var step_timer:float = 0.35
@export var step_randomnes:float = 0.08
@export var step_force:float = 250
@export var drag:float = 3

@export var follow_range:float = 0
@export var borders:bool = true

## Behaviour
@export var sprite_size:float = 1
@export var click_force:float = 1000
@export var texture1:Texture = null
@export var texture2:Texture = null
@export var always_on_top:bool = true
#@export var sleep_timer:float = 140
#@export var sleep_duration:float = 280

## Volume
@export var volume:float = 100
@export var volume_toggle:bool = true

@export var sound1:Array[AudioStream];
@export var sound2:AudioStream = null;
@export var sound3:AudioStream = null;
@export var sound4:AudioStream = null;
