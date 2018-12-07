extends Node2D

enum STATE{
	BUILDING
	CONSTRUCTED
}

var state

func _ready():
	state = BUILDING
	$CONSTRUCTED.visible = false

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass$

func _draw():
	draw_circle($CONSTRUCTED.position, 100, Color(0, 1, 0, 0.25))

func _physics_process(delta):
	if state == BUILDING:
		var mouse_pos = get_global_mouse_position()
		$BUILDING.position = mouse_pos
		if $BUILDING/Area2D.get_overlapping_bodies().empty() or $BUILDING/Area2D.get_overlapping_bodies().has($CONSTRUCTED):
			$BUILDING.modulate = Color(0, 1, 0, 0.5)
		else:
			$BUILDING.modulate = Color(1, 0, 0, 0.5)
			
		if Input.is_action_pressed("clic"):
			if $BUILDING/Area2D.get_overlapping_bodies().empty() or $BUILDING/Area2D.get_overlapping_bodies().has($CONSTRUCTED):
				$BUILDING.visible = false
				state = CONSTRUCTED
				$CONSTRUCTED.position = $BUILDING.position
				$CONSTRUCTED.visible = true
				global.generateurArray.append(self)
	elif state == CONSTRUCTED:
		update()
		
func on_interact():
	pass