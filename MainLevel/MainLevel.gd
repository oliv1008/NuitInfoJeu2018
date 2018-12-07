extends Node2D

onready var CrystalScene = preload("res://InteractableObject/Cristal/Cristal.tscn")
onready var ArtifactScene = preload ("res://InteractableObject/Artifact/Artifact.tscn")
onready var tilemap = $TileMap

func _ready():
	for i in range(0, 100):
		for j in range(0, 100):
			tilemap.set_cell(i, j, randi() % 4)
			
	#A FAIRE
#	CHANGER LA PROBA EN FONCTION DE LA DISTANCE PAR RAPPORT AU CENTRE
	for i in range(0, 100):
		var crystal_pos = Vector2(randi()% 100*32, randi()% 100*32)
		var crystal = CrystalScene.instance()
		crystal.position = crystal_pos
		add_child(crystal)
		
	for i in range(0, 10):
		var artifact_pos = Vector2(randi()% 100*32, randi()% 100*32)
		var artifact = ArtifactScene.instance()
		artifact.position = artifact_pos
		add_child(artifact)
		
	$Player.init({"CanvasLayer" : $CanvasLayer})
	$Player.position = tilemap.map_to_world(Vector2(50, 50))
	$CanvasLayer/UI.init({"Level" : self})
	global.foodClockStart()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
