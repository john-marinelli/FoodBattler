extends Control
signal resume()
signal textResume()

var awaitTextContinue = false
var player = null
var enemy = null

onready var textInfo = get_node("battleWindow/battleUI/actionMenuContainer/actionMenu/HBoxContainer/InfoText")
onready var actionMenuContainer = get_node("battleWindow/battleUI/actionMenuContainer/actionMenu/HBoxContainer/menuContainer")
onready var actionMenu = get_node("battleWindow/battleUI/actionMenuContainer/actionMenu")
onready var enemyInfo = get_node("battleWindow/battleUI/monsterInfoContainer/enemyInfo")
onready var playerInfo = get_node("battleWindow/battleUI/monsterInfoContainer/playerInfo")
onready var actionGrid = actionMenuContainer.get_node("optionGrid")
onready var tween = get_node("Tween")
func _ready():
	pass

func _process(_delta):
	if awaitTextContinue:
		if Input.is_action_just_pressed("ui_accept"):
			emit_signal("resume")
			

func showBattleText(string):
	
	actionMenu.showText(string)
	yield(actionMenu,"textShown")
	awaitTextContinue = true
	
func isPlayersTurn(boolean):
	if boolean:
		actionMenu.showText("What will you do?")
		goto_mainActionMenu()
	actionMenuContainer.visible = boolean
	awaitTextContinue = !boolean

func updateUI(player, enemy):
	updateInfoBox(player, playerInfo)
	updateInfoBox(enemy, enemyInfo)

func updateInfoBox(_target, infoBox):
	var monster = _target.currentMonster
	var monster_name = infoBox.get_node("VBoxContainer/Name")
	var monster_hp_val = infoBox.get_node("VBoxContainer/HBoxContainer/hpValue")
	var monster_hp_prog = infoBox.get_node("VBoxContainer/HBoxContainer/hpProg")
	var monster_mp_val = infoBox.get_node("VBoxContainer/HBoxContainer2/mpValue")
	var monster_mp_prog = infoBox.get_node("VBoxContainer/HBoxContainer2/mpProg")
	monster_name.text = monster.monster_name
	monster_hp_val.text = str(ceil(monster.health)) + "/" + str(ceil(monster.max_health))
	monster_hp_prog.max_value = 100
	tween.interpolate_property(monster_hp_prog, "value", monster_hp_prog.value,float(monster.health/float(monster.max_health)) * 100.0,
	0.3,Tween.TRANS_CUBIC )
	tween.start()
	
func goto_mainActionMenu():
	
	var actionItems = ["Fight", "Bag", "Foods", "Run"]
	
	clearActionMenuBtns()
	
	for item in actionItems:
		
		var btn = Button.new()
		btn.text = item
		btn.size_flags_horizontal = SIZE_EXPAND_FILL
		btn.connect("pressed", self, "onActionItemPressed", [item])
		actionGrid.add_child(btn)

func onActionItemPressed(string):
	
	
	print(string)

	match string:
		"Fight":
			showAbilityBtns()
		"Bag":
			pass
		"Foods":
			pass
		"Run":
			pass
			

func showAbilityBtns():
	
	clearActionMenuBtns()
	var currentMonster = player.currentMonster
	for ability in currentMonster.abilities:
		var btn = Button.new()
		btn.text = ability.ability_name
		btn.size_flags_horizontal = SIZE_EXPAND_FILL
		
		btn.connect("pressed", self, "onAbilityPressed", [ability,enemy.currentMonster])
		
		if !ability.signalCreated:
			ability.connect("decision", player, "decide")
			ability.signalCreated = true
		
		actionGrid.add_child(btn)
		
func onAbilityPressed(ability, target):
	ability.perform(target)
	actionMenuContainer.visible = false
	
	
func clearActionMenuBtns():
	for child in actionGrid.get_children():
		child.queue_free()
