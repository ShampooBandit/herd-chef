class_name PartySheep
extends BaseSheep

const TRAVEL_SHEEP_SCENE_UID : String = "uid://d1lgxx201qkqe"

var given_name : String = ""
var description : String = ""

var hunger : float = 1.0
var morale : float = 1.0

# Sent on task/recovering
var occupied : bool = false
var grazing : bool = false
var time_available : float = 0.0

# Movement speed relative to the cart
# Above 1 -> moving faster
# Below 1 -> moving slower
var pace : float = 1.0

# Profession provides bonus stats and other beneficial effects
var profession : Profession = null

# Taste determines preferences for food/corruptions/tfs
var taste = null

# Special ability has an effect
var ability : Effect = null

# Stats comprise of 
# Brawn       - pull from sticky situations, gathering
# Bartering   - trade, town access
# Wrangling   - steering wagon, hunting, controlling beasts
# Mystical    - cursed phenomena, healing metamorphosis
# Grit        - resist curses, food susceptibility
# Sidewinding - navigation, stealth, low society
# Chic        - opposite of sidewinding
var stats : Array = [0, 0, 0, 0, 0, 0, 0]

# List of body part locations by id, update to newest TF when hitting threshold
var tf_modifications : Array = [0,0,0,0]

# Curse -> species/traits from food tf
# When hitting threshold, goes on occupied cooldown
var curse1 : TFTrack = null
var curse1_amount : float = 0.0
var curse2 : TFTrack = null
var curse2_amount : float = 0.0

# Simple testing values for init
func _init() -> void:
	profession = Profession.new()
	profession.title = "Leader"
	profession.description = "With a natural proclivity towards taking charge,
	this character easily secures passage, fairer prices, and camp sites. +3 Bartering\n"
	
	description = "This character has positioned themselves as the group leader for your party and their
	opinion impacts everyone. Reduces party suspicion."
	ability = (Effect.new(
		7,
		func(): 
			return self.suspicion > 0.5,
		func(): 
			return -0.2
	))
	
	curse1 = TFTrack.new()

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
