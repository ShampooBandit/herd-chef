class_name Transformation
extends Node

# Individual change to character
# -body part location
# -effect
# -

# Identifier for body part, 0 = overall tf
var body_part : int = -1
var effect : Effect = null
var title : String = ""

func _init(id: int) -> void:
	match id:
		1: # Reeking tail
			title = "Reeking Tail"
		2: # Delicate fangs
			title = "Delicate Fangs"
		3: # Muskalid base
			title = "Muskalid"
