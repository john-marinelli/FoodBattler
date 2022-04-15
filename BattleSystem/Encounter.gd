extends Node
class_name Encounter
signal battle_state(first)

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


func _init(_player, _enemy):
	enemy = _enemy
	player = _player
	

func player_goes_first():
	var dice = Globals.DICE
	var accum_player_level:int
	var accum_enemy_level:int
	
	for monster in player.monsters:
		
		accum_player_level += monster.level
		
	for monster in enemy.monsters:
		
		accum_enemy_level += monster.level
		
	current_player = enemy
	
	if ((accum_player_level * randi()%dice) > (accum_enemy_level * randi()%dice)):
		
		current_player = player
		
		return true
		
	return false
		
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var battle_string = "Enemy goes first!"
	
	if player_goes_first():
		
		battle_string = "You go first!"
	
	emit_signal("battle_state", battle_string)
	
	yield(current_player, "input_received")
	

func check_end():
	if !areMonstersDefeated(player):
		return player
	if !areMonstersDefeated(enemy):
		return enemy
	return false
		

func areMonstersDefeated(_target):
	var check = false
	for monster in _target.monsters:
		if monster.health > 0:
			check = true
	return check
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
