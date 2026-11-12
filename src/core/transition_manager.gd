class_name TransitionManager
extends Node

signal screen_hidden
signal screen_shown

var anim_player : AnimationPlayer = null

func hide_screen(transition_name: String, blend: float = -1, speed: float = 1.0) -> void:
	anim_player.animation_finished.connect(_on_screen_hidden)
	anim_player.play(transition_name, blend, speed)

func show_screen(transition_name: String, blend: float = -1, speed: float = 1.0) -> void:
	anim_player.animation_finished.connect(_on_screen_shown)
	anim_player.play(transition_name, blend, speed)

func _on_screen_hidden(_anim_name: String) -> void:
	screen_hidden.emit()
	anim_player.animation_finished.disconnect(_on_screen_hidden)

func _on_screen_shown(_anim_name: String) -> void:
	screen_shown.emit()
	anim_player.animation_finished.disconnect(_on_screen_shown)
