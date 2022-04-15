extends Node
signal input_received()
signal decision_signal(val)

var monsters = []


func _ready():
	pass 

func add_monster(monster):
	monsters.append(monster)

func decide():
	var decision
	#TODO receive signals from UI here
	emit_signal("decision_signal", decision)
	emit_signal("input_received")
	pass
