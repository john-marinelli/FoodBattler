extends Node

var currentInterior
var player
func _ready():
	pass
func enterInterior(path):
	player.lastPosition = player.position
	currentInterior = load(path).instance()
	currentInterior.position = Vector2(-1000,-1000)
	get_tree().get_root().add_child(currentInterior)
	player.position = currentInterior.get_node("player_spawn").global_position
	

func leaveInterior():
	currentInterior.queue_free()
	player.position = player.lastPosition
	
