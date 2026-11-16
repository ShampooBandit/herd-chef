class_name Wagon
extends Node2D

var body_condition : float = 1.0
var wheel_conditions : Dictionary = {
	"front_left": 1.0,
	"front_right": 1.0,
	"rear_left": 1.0,
	"rear_right": 1.0
}
var yoke_condition : float = 1.0
var reigns_condition : float = 1.0

@onready var anim_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim_player.play("move")
	anim_player.pause()
