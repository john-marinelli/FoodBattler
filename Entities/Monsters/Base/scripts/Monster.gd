extends Node
class_name Monster
signal monsterAttack(dmg)
signal monsterDefend(res)

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


var health:float
var attack:float
var attackMod:float

var stun := 0

var level:int = 0
var xp = 0
var xpToNextLvl = 100
var hpScale:float


var resistances := []
var type #to store FOODTYPE
var abilities := []
var state = STATES.DECIDE
var defense = 0
func _ready():
	pass 

func _init(ethnicity, monster_name):
	ethnicity = loadMonster(ethnicity)
	var monster = ethnicity[monster_name]
	monster_name = monster["name"]
	health = monster["base_health"]
	hpScale = monster['health_scaling']
	rarity = monster["rarity"]
	var _abilities = monster['base_moveset']
	for ability in _abilities:
		ability = Ability.new(self, ability)
		abilities.append(ability)
	
		
	

	

func loadMonster(ethnicity):
	var monsters = Globals.loadJSON(file_path)
	return monsters[ethnicity]
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
