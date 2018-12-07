extends Node2D

onready var MusicPlayer = $AudioStreamPlayer

func _ready():
	music_stop()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func music_play():
	MusicPlayer.play()
	
func music_stop():
	MusicPlayer.stop()