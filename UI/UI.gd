extends Control

onready var woodLabel = $RessourceLabelContainer/WoodLabel
onready var hungerLabel = $RessourceLabelContainer/HungerLabel
onready var ArtifactLabel = $RessourceLabelContainer/ArtifactLabel

var level
var lastBuildingRef = null
enum STATE{
	BUILDING
	CONSTRUCTED
}

onready var LabButton = $BuildMenuContainer/BuildButtonContainer/Laboratoire
onready var GeneButton = $BuildMenuContainer/BuildButtonContainer/Generateur
onready var FarmButton = $BuildMenuContainer/BuildButtonContainer/Ferme
onready var ObsButton = $BuildMenuContainer/BuildButtonContainer/Observateur
onready var GarageButton = $BuildMenuContainer/BuildButtonContainer/Garage

var LabScene = preload("res://Buildings/Lab/Lab.tscn")
var FarmScene = preload("res://Buildings/Ferme/Ferme.tscn")
var GarageScene = preload("res://Buildings/Garage/Garage.tscn")
var GenerateurScene = preload("res://Buildings/Generateur/Generateur.tscn")
var ObservateurScene = preload("res://Buildings/Observateur/Observateur.tscn")

func _ready():
	pass

func _process(delta):
	if global.crystals < 5:
		GarageButton.disabled = true
		ObsButton.disabled = true
	else:
		GarageButton.disabled = false
		ObsButton.disabled = false
		
	if global.crystals < 10:
		LabButton.disabled = true
		GeneButton.disabled = true
	else:
		LabButton.disabled = false
		GeneButton.disabled = false
		
	if global.crystals < 15:
		FarmButton.disabled = true
	else:
		FarmButton.disabled = false

func init(argumentData):
	if argumentData.has("Level"):
		level = argumentData["Level"]

func _physics_process(delta):
	woodLabel.text = str("Cristaux disponible : ", global.crystals)
	hungerLabel.text = str("Faim : ", global.hunger)
	ArtifactLabel.text = str("Artefacts : ", global.nbArtifact, "/10")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_CloseButton_pressed()

func _on_Laboratoire_pressed():
	if lastBuildingRef != null and lastBuildingRef.state == BUILDING:
		lastBuildingRef.free()
		lastBuildingRef = null
	if global.crystals >= 10:
		global.crystals -= 10
		var lab = LabScene.instance()
		level.add_child(lab)
		lastBuildingRef = lab

func _on_Ferme_pressed():
	if lastBuildingRef != null and lastBuildingRef.state == BUILDING:
		lastBuildingRef.queue_free()
		lastBuildingRef = null
	if global.crystals >= 15:
		global.crystals -= 15
		var farm = FarmScene.instance()
		level.add_child(farm)
		lastBuildingRef = farm


func _on_Garage_pressed():
	if lastBuildingRef != null and lastBuildingRef.state == BUILDING:
		lastBuildingRef.free()
		lastBuildingRef = null
	if global.crystals >= 5:
		global.crystals -= 5
		var garage = GarageScene.instance()
		level.add_child(garage)
		lastBuildingRef = garage


func _on_BuildMenuButton_pressed():
	$BuildMenuButton.visible = false
	$BuildMenuContainer.visible = true


func _on_CloseButton_pressed():
	if lastBuildingRef != null and lastBuildingRef.state == BUILDING:
		lastBuildingRef.free()
		lastBuildingRef = null
	$BuildMenuButton.visible = true
	$BuildMenuContainer.visible = false


func _on_Generateur_pressed():
	if lastBuildingRef != null and lastBuildingRef.state == BUILDING:
		lastBuildingRef.free()
		lastBuildingRef = null
	if global.crystals >= 10:
		global.crystals -= 10
		var generateur = GenerateurScene.instance()
		level.add_child(generateur)
		lastBuildingRef = generateur


func _on_Observateur_pressed():
	if lastBuildingRef != null and lastBuildingRef.state == BUILDING:
		lastBuildingRef.free()
		lastBuildingRef = null
	if global.crystals >= 5:
		global.crystals -= 5
		var observateur = ObservateurScene.instance()
		level.add_child(observateur)
		lastBuildingRef = observateur
