@tool
extends Node2D

func _init() -> void:
	rotate(deg_to_rad(-160))

func _draw() -> void:
	draw_circle(Vector2(770.0, 0.0), 60.0, Color.YELLOW)
