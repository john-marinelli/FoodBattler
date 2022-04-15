extends Node
class_name Monster
signal monsterAttack(dmg)
signal monsterDefend(res)

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

var health:float
var attack:float
var level:int
var resistances := []
var type #to store FOODTYPE
var abilities := []
var state = STATES.DECIDE
var timer
func _ready():
	pass 

func _init(_health):
	health = _health
	
	timer = Timer.new()
	timer.connect("timeout", self, "_timeout")
	
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
