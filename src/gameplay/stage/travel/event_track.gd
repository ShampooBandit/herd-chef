@tool
extends Node2D

func _draw() -> void:
	draw_arc(Vector2.ZERO, 400, PI, 2*PI, 50, Color.DARK_OLIVE_GREEN, 40.0)
