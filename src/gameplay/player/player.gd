class_name Player
extends Node

var gold : int = 1000
var party : Dictionary = {}
var cargo : Dictionary = {}
var oxen : bool = true
var wagon : Wagon = null
var travel_speed : float = 0.0
var travel_distance : float = 0.0
var corruption : float = 0.0

# Effects added from curses/profession/ability/etc will be appended/removed from these arrays
# then referenced when events or other interactions happen that they would affect
var effects_on_event_succeed : Array = []
var effects_on_event_fail : Array = []
var effects_on_event_start : Array = []
var effects_on_event_end : Array = []
var effects_on_event_choice : Array = []
var effects_on_suspicion_gain : Array = []
var effects_on_suspicion_lose : Array = []
var effects_on_suspicion_check : Array = []
var effects_on_town_enter : Array = []
var effects_on_town_exit : Array = []
var effects_on_wagon_break : Array = []
var effects_on_wagon_repair : Array = []
var effects_on_oxen_lose : Array = []
var effects_on_oxen_gain : Array = []
var effects_on_hunt_succeed : Array = []
var effects_on_hunt_fail : Array = []
var effects_on_gather_succeed : Array = []
var effects_on_gather_fail : Array = []
var effects_on_curse_gain : Array = []
var effects_on_curse_lose : Array = []
var effects_on_party_gain : Array = []
var effects_on_party_lose : Array = []
var effects_on_party_rest : Array = []
var effects_on_party_eat : Array = []

func _init() -> void:
	wagon = Wagon.new()
	
	party["Brilliam"] = PartySheep.new()

func update_party_effects() -> void:
	pass
