class_name TravelStage
extends BaseStage

enum TravelState {
	WAITING,
	MOVING,
	EVENT
}

signal minor_event(event: MinorEvent)
signal major_event(event: MajorEvent)
signal end_of_day

var state := TravelState.WAITING
var time := 6.0
var destination := 15.0
var daily_events : Dictionary = {}

@onready var bg_layer1 : Parallax2D = $BackgroundLayers/ParallaxLayer1
@onready var bg_layer2 : Parallax2D = $BackgroundLayers/ParallaxLayer2
@onready var bg_layer3 : Parallax2D = $BackgroundLayers/ParallaxLayer3
@onready var bg_layer4 : Parallax2D = $BackgroundLayers/ParallaxLayer4

@onready var wagon : Wagon = $Wagon
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var clock_sun := $ClockLayers/Sun

# Camping and towns and shops are all in this same scene
# Camping
# -------
# Characters move to set positions based on factors
# Decide on meals
# Main campfire button to progress the night
# Listen in on convos before moving on
# Shop at towns before sleeping
# -------
# Dreams
# -------
# Trigger sometimes after camping to show tf stuff

func init() -> void:
	pass

func generate_daily_events() -> void:
	pass

func start_parallax() -> void:
	bg_layer1.autoscroll = Vector2(75.0, 0.0)
	bg_layer2.autoscroll = Vector2(50.0, 0.0)
	bg_layer3.autoscroll = Vector2(25.0, 0.0)
	bg_layer4.autoscroll = Vector2(10.0, 0.0)

func stop_parallax() -> void:
	bg_layer1.autoscroll = Vector2(0.0, 0.0)
	bg_layer2.autoscroll = Vector2(0.0, 0.0)
	bg_layer3.autoscroll = Vector2(0.0, 0.0)
	bg_layer4.autoscroll = Vector2(0.0, 0.0)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("dialogic_default_action"):
		if state == TravelState.WAITING:
			start_parallax()
			wagon.anim_player.play()
			state = TravelState.MOVING
		else:
			stop_parallax()
			wagon.anim_player.pause()
			state = TravelState.WAITING
	
	match state:
		TravelState.MOVING:
			time += ((0.16667) * _delta)
			clock_sun.rotate(deg_to_rad(2.5) * _delta)
	
	if time >= 20:
		end_of_day.emit()
