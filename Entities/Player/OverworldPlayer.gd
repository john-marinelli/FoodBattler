extends KinematicBody2D
var speed = 50
var input:Vector2
var lastPosition
onready var sprite:AnimatedSprite = get_node("AnimatedSprite")
onready var eventHandler = get_node("eventHandler")
func _ready():
	SceneChanger.player = self
func _process(delta):
	get_input()
	if input.y != 0 or input.x != 0:
		sprite.playing = true
		animationController()
	else:
		sprite.playing = false
		sprite.frame = 1
	var velocity = input * speed * delta
	move_and_collide(velocity)
	if detectEvents():
		if Input.is_action_just_pressed("ui_accept"):
			var events = eventHandler.get_overlapping_areas()
			if events[0] is WorldEvent:
				events[0].interact()
func get_input():
	var UP = Input.is_action_pressed("ui_up")
	var RIGHT = Input.is_action_pressed("ui_right")
	var LEFT = Input.is_action_pressed("ui_left")
	var DOWN = Input.is_action_pressed("ui_down")
	
	input.y = -int(UP) + int(DOWN)
	input.x = -int(LEFT) + int(RIGHT)
	if input.y != 0 and input.x != 0:
		input.y = 0
func animationController():
	if input.y > 0:
		sprite.animation = "walk_down"
	elif input.y < 0:
		sprite.animation = "walk_up"
	elif input.x > 0:
		sprite.animation = "walk_right"
	elif input.x < 0:
		sprite.animation = "walk_left"
func detectEvents():
	if eventHandler.get_overlapping_areas().size() > 0:
		return true
	return false
