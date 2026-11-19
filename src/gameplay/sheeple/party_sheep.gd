class_name PartySheep
extends BaseSheep

const TRAVEL_SHEEP_SCENE_UID : String = "uid://d1lgxx201qkqe"

var given_name : String = ""
var description : String = ""

var suspicion : float = 0.0
var hunger : float = 1.0
var corruption : float = 0.0
var morale : float = 1.0

# Profession provides bonus stats and other beneficial effects
var profession : Profession = null

# Taste determines preferences for food/corruptions/tfs
var taste = null

# Special ability has a condition and effect
var ability = null

# Stats comprise of 
# Brawn/Gumption - pull from sticky situations, gathering
# Bartering - trade, town access
# Wrangling/Coralle - steering wagon, hunting, controlling beasts
# Mystical/Augury - cursed phenomena, healing metamorphosis
# Werewithal/Grit - resist curses, food susceptibility
# Sidewinding - navigation, stealth, low society
# Chic - opposite of sidewinding
var stats : Array = [0, 0, 0, 0, 0, 0, 0]

# Curse -> species/traits from food tf
var curse = null

# Simple testing values for init
func _init() -> void:
	profession = Profession.new()
	profession.title = "Leader"
	profession.description = "With a natural proclivity towards taking charge,
	this character easily secures passage, fairer prices, and camp sites. +3 Bartering\n
	\n
	This character has positioned themselves as the group leader for your party and their
	opinion impacts everyone. While in good standing with them, group suspicion is reduced."
	profession.effects.append(Effect.new(
		7,
		func(): 
			return self.suspicion > 0.5,
		func(): 
			return -0.2
	))

func create_travel_avatar() -> TravelSheep:
	var avatar_scene : PackedScene = ResourceLoader.load(TRAVEL_SHEEP_SCENE_UID)
	if avatar_scene == null:
		push_error("Could not load player scene: " + TRAVEL_SHEEP_SCENE_UID)
		return null
	
	var avatar = avatar_scene.instantiate() as TravelSheep
	if avatar == null:
		push_error("Loaded travel avatar scene does not extend TravelSheep or DNE: " + TRAVEL_SHEEP_SCENE_UID)
		return null
	
	# Initialize the avatar to this particular sheep's attributes here

	return avatar
