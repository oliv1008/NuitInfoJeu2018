extends Node2D

enum STATE{
	BUILDING
	CONSTRUCTED
}

var state
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
				global.playerRef.SPEED += 40
	elif state == CONSTRUCTED:
		pass
		
func on_interact():
	pass