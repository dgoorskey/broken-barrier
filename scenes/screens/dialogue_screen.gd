extends Screen
class_name DialogueScreen

@export var next_dialogue_screen: DialogueScreen

@onready var text: RichTextLabel = $%Text
@onready var option_1: RichTextLabel = $%Option1
@onready var option_2: RichTextLabel = $%Option2
@onready var option_3: RichTextLabel = $%Option3
@onready var option_4: RichTextLabel = $%Option4

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
	
	var left_character_icon := "res://paint.net/character_icon_1.png"
	var right_character_icon := "res://paint.net/character_icon_2.png"

func show_dialogue_line(line: DialogueLine) -> void:
	text.clear()
	text.append_text("[b]%s:[/b] %s" % [line.speaker, line.line])
	
	option_1.clear()
	option_1.append_text(line.option_1)
	option_2.clear()
	option_2.append_text(line.option_2)
	option_3.clear()
	option_3.append_text(line.option_3)
	option_4.clear()
	option_4.append_text(line.option_4)

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
	
	if Input.is_action_just_pressed("p1_a"):
		can_accept_input = false
		input_cooldown.start()
		next_line()

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
