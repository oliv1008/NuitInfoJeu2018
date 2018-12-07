extends Control

onready var label = $Label

func _ready():
	label.text = str("Vous avez recupere ", global.nbArtifact, " artefacts sur 10 en ", global.timeElapsed % 60 ," s !\nMerci d'avoir joue !")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
