class_name PartySheep
extends BaseSheep

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
