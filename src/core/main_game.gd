class_name MainGame
extends Node

enum GameState {
	MAIN_MENU,
	INTRO,
	TRAVEL,
	TOWN,
	SHOP,
	CAMPING,
	DREAM,
	MORNING,
	CUTSCENE
}

const MAIN_MENU_SCENE_UID : String = "uid://cp4ybuw5kb7r4"
const INTRO_SCENE_UID : String = "uid://cgei5rrnrfcd7"
const TRAVEL_SCENE_UID : String = "uid://doyuph0m76vg3"
const TOWN_SCENE_UID : String = "uid://drhq2o5khy2i7"
const CAMPING_SCENE_UID : String = "uid://0to6harmdcbc"

const TRAVEL_GUI_SCENE_UID : String = "uid://cmfa0y3esr1my"

const PLAYER_SCENE_UID : String = "uid://cmq004qn5q3bf"

var player : Player = null
var current_stage : BaseStage = null
var current_gui : BaseGUI = null
var game_state := GameState.MAIN_MENU

# Game System Nodes
@onready var transition_manager : TransitionManager = %ScreenTransitionManager
@onready var event_manager : EventManager = %EventManager
@onready var gui_manager : GUIManager = %GUIManager

# Game World Root Nodes
@onready var stage_root  : Node2D = %StageRoot
@onready var entity_root : Node2D = %EntityRoot
@onready var gfx_root : Node2D = %GFXRoot

# UI Root Nodes
@onready var gui_root        : Control = %GUIRoot
@onready var pause_root      : Control = %PauseRoot
@onready var transition_root : Control = %TransitionRoot
@onready var debug_root      : Control = %DebugRoot

func _ready() -> void:
	load_stage(MAIN_MENU_SCENE_UID)
	_init_game()

func _init_game() -> void:
	game_state = GameState.MAIN_MENU
	transition_manager.anim_player = $TransitionLayer/TransitionPlayer

func _init_player() -> void:
	var player_scene : PackedScene = ResourceLoader.load(PLAYER_SCENE_UID)
	if player_scene == null:
		push_error("Could not load player scene: " + PLAYER_SCENE_UID)
		return
	
	player = player_scene.instantiate() as Player
	if player == null:
		push_error("Loaded player scene does not extend player or DNE: " + PLAYER_SCENE_UID)
		return
	
	entity_root.add_child(player)

func load_stage(stage_scene : String) -> void:
	_deferred_load_stage.call_deferred(stage_scene)

func _deferred_load_stage(stage_scene_uid : String) -> void:
	if current_stage != null:
		current_stage.queue_free()
		current_stage = null
	
	await get_tree().process_frame
	
	var new_map_packed : PackedScene = ResourceLoader.load(stage_scene_uid, "PackedScene") as PackedScene
	if new_map_packed == null:
		push_error("Could not load map as a packed scene: " + stage_scene_uid)
		return
	
	current_stage = new_map_packed.instantiate() as BaseStage
	if current_stage == null:
		push_error("Loaded map is not of type Map or does not exist")
		return
	
	_connect_stage_signals(current_stage)
	
	stage_root.add_child(current_stage)
	
	await get_tree().process_frame

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

func _connect_stage_signals(stage_scene: BaseStage) -> void:
	if stage_scene is MainMenuStage:
		current_stage.start_game.connect(start_new_game)

func start_new_game() -> void:
	transition_manager.screen_hidden.connect(load_intro)
	transition_manager.hide_screen("fade_out")
	game_state = GameState.INTRO

func load_intro() -> void:
	transition_manager.screen_hidden.disconnect(load_intro)
	
	load_stage(INTRO_SCENE_UID)
	init_intro()

func init_intro() -> void:
	transition_manager.screen_shown.connect(Dialogic.start.bind("intro"))
	transition_manager.show_screen("fade_in")
	Dialogic.timeline_ended.connect(end_intro)

func end_intro() -> void:
	transition_manager.screen_shown.disconnect(Dialogic.start.bind("intro"))
	transition_manager.screen_hidden.connect(load_travel)
	transition_manager.hide_screen("fade_out")
	game_state = GameState.TRAVEL

func load_travel() -> void:
	transition_manager.screen_hidden.disconnect(load_travel)
	
	load_stage(TRAVEL_SCENE_UID)
	load_gui(TRAVEL_GUI_SCENE_UID)
	init_travel()

func init_travel() -> void:
	transition_manager.show_screen("fade_in")

func end_travel() -> void:
	transition_manager.screen_hidden.connect(load_town)
	transition_manager.hide_screen("fade_out")
	game_state = GameState.TOWN

func load_town() -> void:
	transition_manager.screen_hidden.disconnect(load_town)
	
	load_stage(TOWN_SCENE_UID)
	init_town()

func init_town() -> void:
	transition_manager.show_screen("fade_in")

func end_town() -> void:
	transition_manager.screen_hidden.connect(load_camping)
	transition_manager.hide_screen("fade_out")
	game_state = GameState.CAMPING

func load_camping() -> void:
	transition_manager.screen_hidden.disconnect(load_camping)
	
	load_stage(CAMPING_SCENE_UID)
	init_camping()

func init_camping() -> void:
	transition_manager.show_screen("fade_in")

func end_camping() -> void:
	pass

func load_dream() -> void:
	pass

func init_dream() -> void:
	pass

func end_dream() -> void:
	pass

func load_morning() -> void:
	pass

func init_morning() -> void:
	pass

func end_morning() -> void:
	pass

func load_cutscene() -> void:
	pass

func init_cutscene() -> void:
	pass

func end_cutscene() -> void:
	pass
