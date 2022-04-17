extends Node
class_name Character

var monsters = []
var bag = []

func _ready():
	pass 
	
func _init(_monsters = [], _bag = []):
	for monster in _monsters:
		var new_monster = Monster.new(monster)
		monsters.append(new_monster)
	for item in _bag:
		bag.append(item)
		
func addMonster(monster, level=1):
	var new_monster = Monster.new(monster, level)
	monsters.append(new_monster)
