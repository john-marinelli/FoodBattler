extends Node
class_name Ability

signal decision(string)

enum MOVES {
	ATTACK,
	STUN,
	DEFEND,
	RUN,
	BUFF,
	DEBUFF
}
enum BUFFS {
	ATTACK,
	SPEED,
	DEFENSE
}

var move_type = MOVES.ATTACK
var buff_type = BUFFS.ATTACK
var ability_name := ""
var monster
var base_stat:int
var lvl_multiplier:int
var isDebuff = false

func _ready():
	pass
	

func _init(monster, ability):
	
	pass

func perform(_target):
	
	var decision_type = ""
	var decision_value = 0
	
	match move_type:
		
		MOVES.ATTACK:
			
			decision_type = "attack"
			attack(_target)
			
		MOVES.BUFF:
			
			decision_type = "buff"
			buff(monster)
			
		MOVES.DEBUFF:
			
			decision_type = "debuff"
			buff(_target)
			

		MOVES.RUN:
			decision_type = "run"
			pass
			
		MOVES.STUN:
			decision_type = "stun"
			decision_value = _get_stun()
			_target.stun = decision_value
	emit_signal("decision", _getMoveString())

	
func buff(_target):
	var roll = _roll()
	if isDebuff:
		roll = -roll
	match buff_type:
		
		BUFFS.ATTACK:
			
			_target.attackMod += roll
			
		BUFFS.DEFENSE:
			
			defend(_target, roll)
			
		BUFFS.SPEED:
			
			pass
	
func attack(target):
	var roll = _roll() + monster.attackMod
	target.health -= (roll-target.defense)
	return roll

func defend(target, roll):
	target.defense += roll
	return roll
	
func _get_stun():
	return floor(monster.level * lvl_multiplier)
	
func _roll():
	var dice = Globals.DICE
	return ceil((lvl_multiplier * monster.level * base_stat) + (randi()%dice * monster.level))

func _getMoveString():
	return monster.monster_name + " performs " + ability_name + "!"
	
	