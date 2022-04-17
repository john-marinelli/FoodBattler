extends PanelContainer
signal textShown()

onready var infoText = get_node("HBoxContainer/InfoText")
onready var optionBtnContainer = get_node("HBoxContainer/menuContainer/optionGrid")
onready var tween = get_node("Tween")
func _ready():
	pass

func showText(string):
	infoText.text = string
	tween.interpolate_property(infoText, "percent_visible", 0, 1, 0.5,Tween.TRANS_LINEAR)
	tween.start()
	yield(tween,"tween_completed")
	emit_signal("textShown")
	
