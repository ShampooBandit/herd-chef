class_name TravelStage
extends BaseStage

enum TravelState {
	WAITING,
	MOVING,
	EVENT
}

var state := TravelState.WAITING

var time := 6.0

var daily_events : Dictionary = {}

@onready var bg_layer1 : Parallax2D = $BackgroundLayers/ParallaxLayer1
@onready var bg_layer2 : Parallax2D = $BackgroundLayers/ParallaxLayer2
@onready var bg_layer3 : Parallax2D = $BackgroundLayers/ParallaxLayer3
@onready var bg_layer4 : Parallax2D = $BackgroundLayers/ParallaxLayer4

@onready var wagon : Wagon = $Wagon
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var clock_sun := $ClockLayers/Sun

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
			time += 0.05
			clock_sun.rotate(deg_to_rad(0.05))
