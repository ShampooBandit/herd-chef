class_name Effect
extends Node

# A general class for things that happen when conditions are met. Will want to
# support defining effects in json or something

var condition = null # Boolean callable that determines if the effect should trigger
var outcome = null # Callable that applies some effect
var type : int = 0 # determines where the effect hooks in

func _init(t: int, cond: Callable, out: Callable) -> void:
	condition = cond
	outcome = out
	type = t
