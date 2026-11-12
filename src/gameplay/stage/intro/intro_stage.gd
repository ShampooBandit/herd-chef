class_name IntroStage
extends BaseStage

@onready var bg : Sprite2D = $Background

func set_bg(background) -> void:
	bg.texture = background
