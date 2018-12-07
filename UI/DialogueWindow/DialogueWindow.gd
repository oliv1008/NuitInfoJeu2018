extends Control

onready var tie = $ColorRect/TextInterfaceEngine
var dialogue
var player

signal dialogue_closed

func _ready():
	# Connect every signal to check them using the "print()" method
	tie.connect("input_enter", self, "_on_input_enter")
	tie.connect("buff_end", self, "_on_buff_end")
	tie.connect("state_change", self, "_on_state_change")
	tie.connect("enter_break", self, "_on_enter_break")
	tie.connect("resume_break", self, "_on_resume_break")
	tie.connect("tag_buff", self, "_on_tag_buff")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func init(dialogue_param, player_param):
	player = player_param
	connect("dialogue_closed", player, "on_dialogue_closed")
	dialogue = dialogue_param
	tie.buff_text(dialogue, 0.03)
	tie.buff_break()
	tie.set_state(tie.STATE_OUTPUT)
	
func _on_input_enter(s):
	print("Input Enter ",s)
	pass

func _on_buff_end():
	print("Buff End")
	pass

func _on_state_change(i):
	print("New state: ", i)
	pass

func _on_enter_break():
	print("Enter Break")
	pass

func _on_resume_break():
	print("Resume Break")
	emit_signal("dialogue_closed")
	queue_free()
	pass

func _on_tag_buff(s):
	print("Tag Buff ",s)
	pass