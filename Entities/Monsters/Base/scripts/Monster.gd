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
var sprite = ""
var monster_name = ""
var rarity:int

var max_health:float
var health:float
var attack:float
var attackMod:float
var defense = 0
var stun := 0

var level:int = 0
var xp = 0
var xpToNextLvl = 100
var hpScale:float

var currentBuffs = {} #contains stuns, poisons {abilityObj: turnLength}

var resistances := []
var strengths := []
var type #to store FOODTYPE
var abilities := []
var state = STATES.DECIDE

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
	sprite = "res://" + monster["icon"]
	var _abilities = monster['base_moveset']
	
	
	for ability in _abilities:
		ability = Ability.new(self, ability)
		abilities.append(ability)
		
	var _resistances = ethnicity["resistances"]
	var _strengths = ethnicity["strengths"]
	
	for resistance in _resistances:
		resistance = resistance.to_upper()
		resistances.append(FOODTYPE.keys().find(resistance))
	for strength in _strengths:
		strength = strength.to_upper()
		strengths.append(FOODTYPE.keys().find(strength))
func getBuffsString():
	var dict = {}
	for buff in currentBuffs.keys():
		for buffString in buff.buffTypesString:
			if !dict.has(buffString):
				dict[buffString] = 0
			dict[buffString] += 1
	return dict
		
		
func getPreturn(): #affinity object has stun or poison, and shows a string
	var buffs = []
	defense = 0
	attackMod = 0
	if currentBuffs.size() > 0:
		for buff in currentBuffs.keys():
			if currentBuffs[buff] == 0:
				currentBuffs.erase(buff)
			else:
				currentBuffs[buff] -= 1
				buffs.append(buff)

				buff.applyBuffs(self)
func isStunned():
	if stun > 0:
		stun -= 1
		return true
	return false
	
	
	
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
