extends Node2D

onready var Ferme1 = preload ("res://Assets/PixelArt/Ferme1.png")
onready var Ferme2 = preload ("res://Assets/PixelArt/Ferme2.png")
onready var Ferme3 = preload ("res://Assets/PixelArt/Ferme3.png")
onready var Ferme4 = preload ("res://Assets/PixelArt/Ferme4.png")

enum STATE{
	BUILDING
	CONSTRUCTED
}

var dialogue = "La recolte est bonne ! (+ 50 de faim)"
var state
var levelFarm = 1
var canBuild

func _ready():
	state = BUILDING
	$CONSTRUCTED.visible = false

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	if state == BUILDING:
		canBuild = false
		var mouse_pos = get_global_mouse_position()
		$BUILDING.position = mouse_pos
		if $BUILDING/Area2D.get_overlapping_bodies().empty() or $BUILDING/Area2D.get_overlapping_bodies().has($CONSTRUCTED):
			for generateur in global.generateurArray:
				if $BUILDING.position.distance_to(generateur.get_node("CONSTRUCTED").position) < 100:
					canBuild = true
			if canBuild:
				$BUILDING.modulate = Color(0, 1, 0, 0.5)
		if !canBuild:
			$BUILDING.modulate = Color(1, 0, 0, 0.5)
			
		if Input.is_action_pressed("clic"):
			if canBuild:
				$BUILDING.visible = false
				state = CONSTRUCTED
				$CONSTRUCTED.position = $BUILDING.position
				$CONSTRUCTED.visible = true
				$Timer.start()
	elif state == CONSTRUCTED:
		pass
		
func on_interact():
	if levelFarm == 4:
		$Timer.stop()
		$CONSTRUCTED/Sprite.texture = Ferme1
		levelFarm = 1
		global.hunger += 50
		if global.hunger > 100:
			global.hunger = 100
		return 1

func _on_Timer_timeout():
	if levelFarm == 1:
		$CONSTRUCTED/Sprite.texture = Ferme2
		levelFarm += 1
	elif levelFarm == 2:
		$CONSTRUCTED/Sprite.texture = Ferme3
		levelFarm += 1
	elif levelFarm == 3:
		$CONSTRUCTED/Sprite.texture = Ferme4
		levelFarm += 1
