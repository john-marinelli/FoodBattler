extends Area2D
class_name WorldEvent
export (String, FILE) var scene 
export (bool) var goToOverworld = false
func _ready():
	pass
func interact():
	if goToOverworld:
		SceneChanger.leaveInterior()
	else:
		SceneChanger.enterInterior(scene)
