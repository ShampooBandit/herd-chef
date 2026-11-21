class_name GUIManager
extends Node

var current_gui = null
var gui_root : Control = null

func _process(_delta: float) -> void:
	pass

func load_gui(gui_scene : String) -> void:
	_deferred_load_gui.call_deferred(gui_scene)

func _deferred_load_gui(gui_scene_uid: String) -> void:
	if current_gui != null:
		current_gui.queue_free()
		current_gui = null
	
	await get_tree().process_frame
	
	var new_gui_packed : PackedScene = ResourceLoader.load(gui_scene_uid, "PackedScene") as PackedScene
	if new_gui_packed == null:
		push_error("Could not load gui as a packed scene: " + gui_scene_uid)
		return
	
	current_gui = new_gui_packed.instantiate() as BaseGUI
	if current_gui == null:
		push_error("Loaded gui is not of type BaseGUI or does not exist")
		return
	
	gui_root.add_child(current_gui)
	
	await get_tree().process_frame

func update_travel_gui(data: Dictionary) -> void:
	gui_root.get_child(0).get_child(1).text = get_clock_text(data.time)

func get_clock_text(time: float) -> String:
	var time_string = ""
	var hours = int(time)
	var minutes = int((time - floor(time)) * 60)
	
	if hours >= 12:
		time_string += str(hours - 12) + ":" + str(minutes).pad_zeros(2) + " PM"
	else:
		time_string += str(hours) + ":" + str(minutes).pad_zeros(2) + " AM"
	
	return time_string
