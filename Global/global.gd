extends Node

var crystals = 0
var hunger = 100
var foodClock
var generateurArray = []
var artifactArray = []
var nbArtifact = 0
var playerRef
var playerName
var timeElapsed = 0
var countTime = false
var requestSent = false

onready var EndScreen = "res://EndScreen.tscn"

func _ready():
	foodClock = Timer.new()
	foodClock.connect("timeout", self, "on_foodClock_timeout")
	add_child(foodClock)
	foodClock.wait_time = 3
	foodClock.start()
	foodClockStop()

func _process(delta):
	if countTime:
		timeElapsed += delta
	if hunger <= 0 and requestSent == false:
		requestSent = true
		lose()

func foodClockStart():
	foodClock.paused = false
	
func foodClockStop():
	foodClock.paused = true
	
func on_foodClock_timeout():
	hunger -= 1
	
func win():
	countTime = false
	var httpRequest = HTTPRequest.new()
	add_child(httpRequest)
	httpRequest.request(str("http://phenixos-lab.ddns.net/n2i/n2iGame/api.php?action=saveScore&pseudo=", playerName, "&score=" , timeElapsed % 60))
	get_tree().change_scene(EndScreen)
	
func lose():
	countTime = false
	var httpRequest = HTTPRequest.new()
	add_child(httpRequest)
	httpRequest.request(str("http://phenixos-lab.ddns.net/n2i/n2iGame/api.php?action=saveScore&pseudo=", playerName, "&score=" , timeElapsed % 60))
	get_tree().change_scene(EndScreen)
	