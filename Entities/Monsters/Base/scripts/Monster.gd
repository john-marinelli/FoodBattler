extends Node
class_name Monster


const file_path = "res://Assets/JSON/monsters.json"
enum FOODTYPE {
	ITALIAN, 
	FRENCH,
	AMERICAN,
	CHINESE, 
	MEXICAN
}
enum STATES {
	ATTACK,
	DEFEND,
	WAIT,
	ESCAPE,
	DECIDE
}

var monster_name = ""
var rarity:int

var max_health:float
var health:float
var attack:float
var attackMod:float

var stun := 0

var level:int = 0
var xp = 0
var xpToNextLvl = 100
var hpScale:float

var affinityDict = {} #contains stuns, poisons {abilityObj: turnLength}

var resistances := []
var strengths := []
var type #to store FOODTYPE
var abilities := []
var state = STATES.DECIDE
var defense = 0
func _ready():
	pass 

func _init(_monster_name, _level = 1):
	var ethnicity = loadMonster(_monster_name)
	var monster = ethnicity[_monster_name]
	monster_name = monster["name"]
	level = _level
	hpScale = monster['health_scaling']
	health = monster["base_health"] + (hpScale * _level)
	max_health = health
	rarity = monster["rarity"]
	var _abilities = monster['base_moveset']
	
	for ability in _abilities:
		ability = Ability.new(self, ability)
		abilities.append(ability)
		
	var _resistances = ethnicity["resistances"]
	var _strengths = ethnicity["strengths"]
	
	for resistance in _resistances:
		resistance = resistance.to_upper()
		print(FOODTYPE.keys().find(resistance))
		resistances.append(FOODTYPE.keys().find(resistance))
	for strength in _strengths:
		strength = strength.to_upper()
		strengths.append(FOODTYPE.keys().find(strength))
	
func getPreturn(): #affinity object has stun or poison, and shows a string
	var affinities = []
	if affinityDict.size() > 0:
		for affinity in affinityDict.keys():
			affinityDict[affinity] -= 1
			affinities.append(affinity)
			if affinityDict[affinity] == 0:
				affinityDict.erase(affinity)
			
	return affinities
		
		
	
	
func resetTurn():
	defense = 0
	

func loadMonster(_monster_name):
	var monsters = Globals.loadJSON(file_path)
	for key in monsters.keys():
		if monsters[key].has(_monster_name):
			return monsters[key]
	print("error!")
	return
	
func state_machine(_delta): #time-based
	match STATES:
		STATES.ATTACK:
			pass
		STATES.DEFEND:
			pass
		STATES.WAIT:
			pass
		STATES.ESCAPE:
			pass
		STATES.DECIDE:
			pass
			

func enter_state(st):
	state = st
	match STATES:
		STATES.ATTACK:
			pass
		STATES.DEFEND:
			pass
		STATES.WAIT:
			pass
		STATES.ESCAPE:
			pass
		STATES.DECIDE:
			pass
			
			
func roll(dice:int):
	return randi()%dice
func _timeout():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#func state_machine(): #for later use
#	match STATES:
#		STATES.ATTACK:
#			pass
#		STATES.DEFEND:
#			pass
#		STATES.WAIT:
#			pass
#		STATES.ESCAPE:
#			pass
#		STATES.DECIDE:
#			pass
