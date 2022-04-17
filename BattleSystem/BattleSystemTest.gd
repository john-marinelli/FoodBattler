extends Node

var player
var enemy
func _ready():
	player = get_node("Node")
	enemy = RandomEncounter.new(player)
	enemy = enemy.handler
	var battleScene = load("res://BattleSystem/BattleScene.tscn").instance()
	add_child(battleScene)
	
	var encounter = Encounter.new(player, enemy, battleScene)
	
	encounter.connect("battle_state", battleScene, "showBattleText")
	encounter.connect("update_ui", battleScene, "updateUI")
	encounter.connect("isPlayersTurn", battleScene, "isPlayersTurn")
	
	
	battleScene.add_child(encounter)
	

	
	
