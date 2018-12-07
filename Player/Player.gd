extends KinematicBody2D

onready var CharaUp = preload ("res://Assets/PixelArt/CharaUp.png")
onready var CharaDown = preload("res://Assets/PixelArt/CharaDown.png")
onready var CharaLeft = preload ("res://Assets/PixelArt/CharaLeft.png")
onready var CharaRight = preload ("res://Assets/PixelArt/CharaRight.png")

var DialogueWindow = preload("res://UI/DialogueWindow/DialogueWindow.tscn")
onready var raycast = $RayCast2D

var direction = Vector2()
var velocity = Vector2()
var canMove = true

var canvasLayer
var collider

var SPEED = 100

func _ready():
	global.playerRef = self
	
func init(argumentData):
	if argumentData.has("CanvasLayer"):
		canvasLayer = argumentData["CanvasLayer"]

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	if canMove:
		if Input.is_action_pressed("up"):
			direction.y = -1
			$Sprite.texture = CharaUp
		elif Input.is_action_pressed("down"):
			direction.y = 1
			$Sprite.texture = CharaDown
		else:
			direction.y = 0
			
		if Input.is_action_pressed("left"):
			direction.x = -1
			$Sprite.texture = CharaLeft
		elif Input.is_action_pressed("right"):
			$Sprite.texture = CharaRight
			direction.x = 1
		else:
			direction.x = 0
	else:
		direction = Vector2(0, 0)
		
	velocity = direction.normalized() * SPEED * delta
	move_and_collide(velocity)
	position.x = clamp(position.x, 0, 3200)
	position.y = clamp(position.y, 0, 3200)
	
	if direction != Vector2(0, 0):
		raycast.cast_to = direction.normalized() * 30
		
	if raycast.is_colliding() and canMove == true:
		collider = raycast.get_collider()
	else:
		collider = null
		
	if Input.is_action_just_pressed("ui_accept") and collider != null:
		if collider.has_method("on_interact"):
			if collider.on_interact():
				global.foodClockStop()
				global.countTime = false
				canMove = false
				var dialogueInstance = DialogueWindow.instance()
				canvasLayer.add_child(dialogueInstance)
				dialogueInstance.init(collider.dialogue, self)
		elif collider.get_parent().get_parent().has_method("on_interact"):
			if collider.get_parent().get_parent().on_interact():
				global.foodClockStop()
				global.countTime = false
				canMove = false
				var dialogueInstance = DialogueWindow.instance()
				canvasLayer.add_child(dialogueInstance)
				dialogueInstance.init(collider.get_parent().get_parent().dialogue, self)
	
func on_dialogue_closed():
	global.foodClockStart()
	global.countTime = true
	call_deferred("canMoveTrue")
	
func canMoveTrue():
	canMove = true