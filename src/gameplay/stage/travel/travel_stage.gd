class_name TravelStage
extends BaseStage

var move := false

@onready var bg_layer1 : Parallax2D = $BackgroundLayers/ParallaxLayer1
@onready var bg_layer2 : Parallax2D = $BackgroundLayers/ParallaxLayer2
@onready var bg_layer3 : Parallax2D = $BackgroundLayers/ParallaxLayer3
@onready var bg_layer4 : Parallax2D = $BackgroundLayers/ParallaxLayer4

func init() -> void:
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
		move = !move

		if move:
			start_parallax()
		else:
			stop_parallax()
