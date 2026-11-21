class_name TFTrack
extends Node

# Line of mutations for a species tf

var tfs : Array = []

func _init() -> void:
	tfs.append(Transformation.new(1))
	tfs.append(Transformation.new(2))
	tfs.append(Transformation.new(3))
