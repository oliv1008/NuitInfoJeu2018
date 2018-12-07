extends Control

onready var tie = $TextInterfaceEngine
onready var MainLevel = ("res://MainLevel/MainLevel.tscn")

func _ready():
	tie.connect("input_enter", self, "_on_input_enter")
	tie.connect("buff_end", self, "_on_buff_end")
	tie.connect("state_change", self, "_on_state_change")
	tie.connect("enter_break", self, "_on_enter_break")
	tie.connect("resume_break", self, "_on_resume_break")
	tie.connect("tag_buff", self, "_on_tag_buff")
	
	tie.buff_text("Please enter your name : ", 0.02)
	tie.buff_input()
	tie.buff_silence(0.1)
	tie.set_state(tie.STATE_OUTPUT)

func _on_demos_list_item_selected( ID ):
	select_demo(ID)

func _on_input_enter(s):
	print("Input Enter = ",s, "<-chaine")
	if s == "":
		print("ici")
		get_tree().reload_current_scene()
	else:
		global.playerName = s

func _on_buff_end():
	print("Buff End")
	MusicPlayer.music_play()
	get_tree().change_scene(MainLevel)

func _on_state_change(i):
	print("New state: ", i)
	pass

func _on_enter_break():
	print("Enter Break")
	pass

func _on_resume_break():
	print("Resume Break")
	pass

func _on_tag_buff(s):
	print("Tag Buff ",s)
	pass