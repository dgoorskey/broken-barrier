extends Node
#AudioStreamPlayer for menu music
@onready var menu = get_parent().get_node("Main/Music/Menu")
#AudioStreamPlayer for general background music
@onready var background = get_parent().get_node("Main/Music/Background")
#AudioStreamPlayer for normal dialogue
@onready var normalDialogue = get_parent().get_node("Main/Music/NormalDialogue")
#AudioStreamPlayer for specific dialogue (Love, Call Out) 
@onready var specificDialogue = get_parent().get_node("Main/Music/SpecificDialogue")

#Sets game state so that correct music file is played
var game_state = null : set = set_game_state

func set_game_state(new_value):
	if not game_state == new_value:
		game_state = new_value
		print("game state = " + game_state)
		change_music()
	else:
		pass

#Changes music file based on game state
func change_music(): 
	match game_state:
		"Menu":
			menu._set_playing(true)
			background._set_playing(false)
			normalDialogue._set_playing(false)
			specificDialogue._set_playing(false)
		"NormalFight":
			menu._set_playing(false)
			background._set_playing(true)
			normalDialogue._set_playing(false)
			specificDialogue._set_playing(false)
		"BossFight":
			menu._set_playing(false)
			background._set_playing(true)
			normalDialogue._set_playing(false)
			specificDialogue._set_playing(false)
		"TalkingNormal":
			menu._set_playing(false)
			background._set_playing(false)
			normalDialogue._set_playing(true)
			specificDialogue._set_playing(false)
		"TalkingLove":
			menu._set_playing(false)
			background._set_playing(false)
			normalDialogue._set_playing(false)
			specificDialogue._set_playing(true)
		"TalkingIntense":
			menu._set_playing(false)
			background._set_playing(false)
			normalDialogue._set_playing(false)
			specificDialogue._set_playing(true)
		"Reset":
			menu._set_playing(false)
			background._set_playing(false)
			normalDialogue._set_playing(false)
			specificDialogue._set_playing(false)
