extends Node
class_name Encounter
signal battle_state(string)
signal update_ui(player, enemy)
signal isPlayersTurn(boolean)
signal resume()
signal battleFinished(winner)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


enum BATTLESTATE {
	ENEMY,
	PLAYER,
}
var enemy
var player
var current_player
var battle_state
var timer
var isBattleFinished = false
var turns = []
var ui = null
func _init(_player, _enemy, _ui):
	enemy = _enemy
	player = _player
	timer = Timer.new()
	timer.wait_time = 2.5
	
	ui = _ui
	ui.player = player
	ui.enemy = enemy
	

func player_goes_first():
	var dice = Globals.DICE
	var accum_player_level:int
	var accum_enemy_level:int
	
	for monster in player.monsters:
		
		accum_player_level += monster.level
		
	for monster in enemy.monsters:
		
		accum_enemy_level += monster.level
		
	current_player = enemy
	
	turns.append(enemy)
	
	if ((accum_player_level * randi()%dice) > (accum_enemy_level * randi()%dice)):
		
		current_player = player
		
		turns.push_front(player)
		
		return true
		
	turns.push_back(player)
	
	return false
		
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	var battle_string = "Enemy goes first!"
	
	if player_goes_first():
		
		battle_string = "You go first!"
	emit_signal("battle_state", battle_string)
	emit_signal("update_ui", player, enemy)
	player.connect("input_recieved", self, "process_turn")
	enemy.connect("input_recieved", self, "process_turn")
	ui.loadSprites()
	yield(ui, "resume")
	execute_turn()
	
	
	
	

func check_end():
	if areMonstersDefeated(player):
		return player
	if areMonstersDefeated(enemy):
		return enemy
	return null
		

func areMonstersDefeated(_target):
	var check = true
	for monster in _target.monsters:
		if monster.health > 0:
			check = false
	return check
		
		
func execute_turn():
	if !isBattleFinished:
		current_player = turns[0]
		##-----------------------------------------------##
		##--------------Start decision phase------------##
		##--------[pre-turn, turn, post-turn]-----------##
		current_player.currentMonster.getPreturn()
		if current_player.currentMonster.isStunned():
			emit_signal("battle_state", current_player.currentMonster.monster_name + " is stunned!" )
			yield(ui, "resume")
			turns.invert()
			execute_turn()
			return
			
		
		emit_signal("isPlayersTurn", _isPlayersTurn())
		if !_isPlayersTurn():
			current_player.decide()

		yield(ui,"resume")
		turns.invert()

		execute_turn()
	
	
func process_turn(string):
	
	emit_signal("battle_state", string)
	
	emit_signal("update_ui", player, enemy)
	
	var winner = check_end()
	if winner != null:
		emit_signal("battle_state", "The battle is over!")
		emit_signal("battleFinished", winner)
		isBattleFinished = true
		return
	
	
		
		
	emit_signal("resume")
func _isPlayersTurn():
	if current_player == player:
		return true
	return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
