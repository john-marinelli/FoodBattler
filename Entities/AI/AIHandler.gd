extends Node

class_name AIHandler

signal input_recieved(decision_string)

var monsters = []
var bag = []
var currentMonster = null
var target = self


func _ready():
	pass
func _init(_monsters, _target):
	randomize()
	monsters = _monsters
	currentMonster = _monsters[0]
	target = _target
	loadMonster(currentMonster)
	print(currentMonster)

func loadMonster(monster):
	for ability in monster.abilities:
		ability.connect("decision", self, "decisionMade")
	

func decide():
	var ability = currentMonster.abilities[randi()%currentMonster.abilities.size()]
	var monsterTarget = target.currentMonster
	ability.perform(monsterTarget)

func decisionMade(decision_string):
	print(decision_string)
	emit_signal("input_recieved", decision_string)
