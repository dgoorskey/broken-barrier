extends Screen
class_name DialogueScreen

@onready var text: RichTextLabel = $%Text
@onready var options_box := $%OptionsBox
@onready var option_1: DialogueOption = $%Option1
@onready var option_2: DialogueOption = $%Option2
@onready var option_3: DialogueOption = $%Option3
@onready var option_4: DialogueOption = $%Option4
@onready var left_character: TextureRect = $%LeftCharacter
@onready var right_character: TextureRect = $%RightCharacter

var is_options := false # True if options are visible and one must be chosen.

class DialogueLine:
	var id := ""      # (optional) Unique id of this DialogueLine
	var speaker := "" # Name of the speaker
	var line := ""    # The text itself
	
	var option_1 := ""        # Option 1 text.
	var option_1_target := "" # DialogueLine id to go to when option is selected.
	
	var option_2 := ""
	var option_2_target := ""
	
	var option_3 := ""
	var option_3_target := ""
	
	var option_4 := ""
	var option_4_target := ""
	
	var left_character_sprite := "res://paint.net/character_icon_1.png"
	var right_character_sprite := "res://paint.net/character_icon_2.png"

func show_dialogue_line(line: DialogueLine) -> void:
	text.clear()
	text.append_text("[b]%s:[/b] %s" % [line.speaker, line.line])
	
	if line.option_1 == "" and line.option_2 == "" and line.option_3 == "" and line.option_4 == "":
		is_options = false
		options_box.visible = false
	else:
		is_options = true
		options_box.visible = true
	
	if line.left_character_sprite != "":
		left_character.texture = load(line.left_character_sprite)
	if line.right_character_sprite != "":
		right_character.texture = load(line.right_character_sprite)
	
	option_1.set_text(line.option_1)
	option_2.set_text(line.option_2)
	option_3.set_text(line.option_3)
	option_4.set_text(line.option_4)
	option_1.grab_focus.call_deferred()

var dialogue_lines: Array[DialogueLine] = []
var current_dialogue_line_idx := 0
func _ready() -> void:
	stop()
	
	var d := DialogueLine.new()
	d.speaker = "Maemi"
	d.line = "Hello!"
	dialogue_lines.append(d)
	
	d = DialogueLine.new()
	d.speaker = "Bystander"
	d.line = "What are you doing here!?"
	dialogue_lines.append(d)
	
	d = DialogueLine.new()
	d.speaker = "Maemi"
	d.line = "your mom"
	dialogue_lines.append(d)

func next_line() -> void:
	current_dialogue_line_idx += 1
	if current_dialogue_line_idx < dialogue_lines.size():
		var current_dialogue_line := dialogue_lines[current_dialogue_line_idx]
		show_dialogue_line(current_dialogue_line)
	else:
		# No more dialogue lines
		stop()

@onready var input_cooldown: Timer = $InputCooldown
func _process(delta: float) -> void:
	if not ui.visible:
		return
	
	if not can_accept_input:
		return
	
	if not is_options:
		if Input.is_action_just_pressed("p1_a"):
			can_accept_input = false
			input_cooldown.start()
			next_line()
	
	SoundScript.SetGameState("TalkingNormal")
	

var can_accept_input := false
func _on_input_cooldown_timeout() -> void:
	can_accept_input = true

@onready var ui: CanvasLayer = $UI
func start() -> void:
	# Prevent weird input issues
	Input.action_release("p1_a")
	Input.flush_buffered_events()
	
	# Reset dialogue back to beginning
	current_dialogue_line_idx = 0
	show_dialogue_line(dialogue_lines[0])
	
	# Pause, and show
	get_tree().paused = true
	ui.visible = true

func stop() -> void:
	# Stop issues where the original p1_a press (before dialogue) gets read
	# after unpausing, reinteracting with InteractionAreas, re-entering the
	# dialogue again.
	Input.action_release("p1_a")
	Input.flush_buffered_events()
	
	# Unpause, and hide
	get_tree().paused = false
	ui.visible = false

func load_json(path: String) -> void:
	dialogue_lines.clear()
	current_dialogue_line_idx = 0
	
	var file := FileAccess.open(path, FileAccess.READ)
	var data: Array = JSON.parse_string(file.get_as_text(true))
	
	for line_data in data:
		var dialogue_line := DialogueLine.new()
		print(line_data)
		dialogue_line.speaker = line_data.get("speaker", "")
		dialogue_line.line = line_data.get("line", "")
		dialogue_line.left_character_sprite = line_data.get("left", "")
		dialogue_line.right_character_sprite = line_data.get("right", "")
		
		dialogue_line.option_1 = line_data.get("option1", "")
		dialogue_line.option_1_target = line_data.get("target1", "")
		dialogue_line.option_2 = line_data.get("option2", "")
		dialogue_line.option_2_target = line_data.get("target2", "")
		dialogue_line.option_3 = line_data.get("option3", "")
		dialogue_line.option_3_target = line_data.get("target3", "")
		dialogue_line.option_4 = line_data.get("option4", "")
		dialogue_line.option_4_target = line_data.get("target4", "")
		
		dialogue_lines.append(dialogue_line)
	
	




func _on_option_1_pressed() -> void:
	var dialogue_line := dialogue_lines[current_dialogue_line_idx]
	var target := dialogue_line.option_1_target
	SoundScript.SetGameState("BossFight")
	if target == "":
		next_line()
	else:
		load_json(target)
		start()

func _on_option_2_pressed() -> void:
	var dialogue_line := dialogue_lines[current_dialogue_line_idx]
	var target := dialogue_line.option_2_target

	if target == "":
		next_line()
	else:
		load_json(target)
		start()

func _on_option_3_pressed() -> void:
	var dialogue_line := dialogue_lines[current_dialogue_line_idx]
	var target := dialogue_line.option_3_target

	if target == "":
		next_line()
	else:
		load_json(target)
		start()

func _on_option_4_pressed() -> void:
	var dialogue_line := dialogue_lines[current_dialogue_line_idx]
	var target := dialogue_line.option_4_target
	if target == "":
		next_line()
	else:
		load_json(target)
		start()
