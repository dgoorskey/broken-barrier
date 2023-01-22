extends Node
#AudioStreamPlayer for menu music
@onready var menu = get_parent().get_node("Main/Music Handler/Menu")
#AudioStreamPlayer for general background music
@onready var background = get_parent().get_node("Main/Music Handler/Background")
#AudioStreamPlayer for normal dialogue
@onready var normalDialogue = get_parent().get_node("Main/Music Handler/NormalDialogue")
#AudioStreamPlayer for specific dialogue (Love, Call Out) 
@onready var specificDialogue = get_parent().get_node("Main/Music Handler/SpecificDialogue")

#Sets game state so that correct music file is played
var game_state = null : set = SetGameState

func SetGameState(new_value):
	if not game_state == new_value:
		game_state = new_value
		print("game state = " + game_state)
		ChangeMusic()
	else:
		pass

func fadeOut(audioStream):
	if not audioStream.get_volume_db() == -40 and audioStream.is_playing():
		var tween = audioStream.create_tween()
		tween.tween_property(audioStream, "volume_db", -40, 2)
		audioStream._set_playing(false)
	
func fadeIn(audioStream):
	if not audioStream.is_playing():
		audioStream.volume_db = -40;
		audioStream._set_playing(true);
		var tween = audioStream.create_tween()
		tween.tween_property(audioStream, "volume_db", 0, 2)

#Changes music file based on game state
func ChangeMusic(): 
	match game_state:
		"Menu":
			fadeIn(menu)
		"NormalFight":
			fadeOut(menu)
			fadeIn(background)
			fadeOut(normalDialogue)
			fadeOut(specificDialogue)
		"BossFight":
			menu._set_playing(false)
			background._set_playing(true)
			normalDialogue._set_playing(false)
			specificDialogue._set_playing(false)
		"TalkingNormal":
			fadeOut(menu)
			fadeOut(background)
			fadeIn(normalDialogue)
			fadeOut(specificDialogue)
		"TalkingLove":
			fadeOut(menu)
			fadeOut(background)
			fadeOut(normalDialogue)
			fadeIn(specificDialogue)
		"TalkingIntense":
			fadeOut(menu)
			fadeOut(background)
			fadeOut(normalDialogue)
			fadeIn(specificDialogue)
		"Reset":
			fadeOut(menu)
			fadeOut(background)
			fadeOut(normalDialogue)
			fadeOut(specificDialogue)


		
