extends Node
signal input_recieved(decision_string)
signal decision_signal(val)

var monsters = []
var player = null
var currentMonster = null
func _ready():
	player = Character.new(['nachos']) 
	monsters = player.monsters
	currentMonster = player.monsters[0]

func add_monster(monster):
	monsters.append(monster)

func decide(ability_string):
	var decision
	#TODO receive signals from UI here
	print(ability_string)
	emit_signal("input_recieved", ability_string)
	pass
