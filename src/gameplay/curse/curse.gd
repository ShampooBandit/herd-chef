class_name Curse
extends Node

var title : String = ""

var ability : Effect = null

var tf_track

func _init() -> void:
	title = "Mustelid"
	ability = Effect.new()
