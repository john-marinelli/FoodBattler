extends Node
class_name Ability

const file_path = "res://Assets/JSON/abilities.json"

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
var signalCreated = false
var move_types = ["attack", "stun", "defend", "run", "buff", "debuff"]
var move_type = MOVES.ATTACK
var buff_types := []
var ability_name := ""
var monster
var cost:int
var base_stat:int
var lvl_multiplier:float
var isDebuff = false
var region = ""
func _ready():
	pass
	
func _init(_monster, _ability):
	
	monster = _monster
	
	var ability = loadAbilities(_ability)
	base_stat = int(ability['base_stat'])
	cost = ability['cost']
	lvl_multiplier = ability['lvl_multiplier']
	ability_name = ability['name']
	region = ability['region']
	
	var type = ability['type'].to_upper()
	
	move_type = MOVES.keys().find(type) #find index of enum
	
	if move_type == MOVES.BUFF or move_type == MOVES.DEBUFF:
		var buffs = ability['buff_type']
		for buff in buffs:
			buff = buff.to_upper()
			buff_types.append(BUFFS.keys().find(buff))
		
		
	

	
	
func loadAbilities(ability):
	var abilityList = Globals.loadJSON(file_path)
	return abilityList[ability]
func perform(_target):
	
	var decision_type = ""
	var decision_value = 0
	monster.defense = 0
	print("targets defense:" ,_target.defense)
	match move_type:
		
		MOVES.ATTACK:
			
			decision_type = "attack"
			attack(_target)
			
		MOVES.BUFF:
			
			decision_type = "buff"
			_target = monster
			applyBuffs(monster)
			
			
		MOVES.DEBUFF:
			
			decision_type = "debuff"
			applyBuffs(_target)
			

		MOVES.RUN:
			decision_type = "run"
			pass
			
		MOVES.STUN:
			decision_type = "stun"
			decision_value = _get_stun()
			_target.stun = decision_value
	emit_signal("decision", _getMoveString(_target))
func applyBuffs(_target):
	
	for buff in buff_types:
		buff(_target, buff)
	
	
func buff(_target, buff_type):
	
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
	var attack = roll - target.defense
	print(attack)
	if target.defense >= roll:
		attack = 0
	print(attack)
	target.health -= attack
	if target.health < 0:
		target.health = 0
	return roll

func defend(target, roll):
	target.defense += roll
	return roll
	
func _get_stun():
	return floor(monster.level * lvl_multiplier)
	
func _roll():
	var dice = Globals.DICE
	return ceil((lvl_multiplier * monster.level * base_stat) + (randi()%dice * monster.level))

func _getMoveString(_target):
	return monster.monster_name + " performs " + ability_name + " on " + _target.monster_name + "!"
	
	
