class_name MainMenuStage
extends BaseStage

signal start_game

func _on_start_game_pressed():
	start_game.emit()
