extends Node
class_name InputBuffer

class InputBufferEvent:
	var input := ""
	var frame := 0
var buffer: Array[InputBufferEvent] = [] # Newest inputs are at the front.

func _process(delta: float) -> void:
	# Scan through all inputs and check if they should be added to the buffer.
	for input in ["p1_left", "p1_right", "p1_up", "p1_down", "p1_jump", "p1_a", "p1_b"]:
		if Input.is_action_just_pressed(input):
			var buffer_event := InputBufferEvent.new()
			buffer_event.input = input.substr(3)
			buffer_event.frame = Game.frame
			buffer.push_front(buffer_event)
	
	# If buffer is too big, remove old inputs.
	while buffer.size() > 20:
		buffer.pop_back()
	
	# Update debug UI
	var debug := $DebugUI/Label as Label
	debug.text = ""
	for buffer_event in buffer:
		debug.text += str(buffer_event.frame) + " " + buffer_event.input + "\n"

func matches(buffer: Array[InputBufferEvent], idx: int, input: String) -> bool:
	if buffer.size() <= idx:
		return false
	if buffer[idx].input == input:
		return true
	return false

# Returns a buffer with only the specified input events.
# - The InputBufferEvents are references, not copies.
func filter(buffer: Array[InputBufferEvent], keep: Array[String]) -> Array[InputBufferEvent]:
	var filtered: Array[InputBufferEvent] = []
	for buffer_event in buffer:
		if buffer_event.input in keep:
			filtered.append(buffer_event)
	return filtered

func starts_with(buffer: Array[InputBufferEvent], sequence: Array[String]) -> bool:
	var idx := 0
	for input in sequence:
		if not matches(buffer, idx, input):
			return false
		idx += 1
	return true

func consume() -> void:
	var null_buffer_event := InputBufferEvent.new()
	null_buffer_event.input = "null"
	null_buffer_event.frame = Game.frame
	buffer.push_front(null_buffer_event)
