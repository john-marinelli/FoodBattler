extends Node
class_name RandomEncounter

var monsterArr = ['spaghetti', 'nachos', 'sandwich']
var monsters = []
var handler = null
var target = null
func _init(_target):
	randomize()
	target = _target
	pickOne()
	handler = AIHandler.new(monsters, target)
func pickOne():
	var selectedMonster = monsterArr[randi()%monsterArr.size()]
	var newMonster = Monster.new(selectedMonster, 1)
	monsters.append(newMonster)
	
