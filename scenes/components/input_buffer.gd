extends Node
class_name InputBuffer

var buffer: Array[String] = [] # Newest inputs are at the front.

func _process(delta: float) -> void:
	# Scan through all inputs and check if they should be added to the buffer.
	for input in ["p1_left", "p1_right", "p1_up", "p1_down", "p1_jump", "p1_a", "p1_b"]:
		if Input.is_action_just_pressed(input):
			buffer.push_front(input)
		if Input.is_action_just_released(input):
#			buffer.push_front("- " + input)
			pass
	
	# If buffer is too big, remove old inputs.
	while buffer.size() > 20:
		buffer.pop_back()
	
	# Update debug UI
	var debug := $DebugUI/Label as Label
	debug.text = ""
	for input in buffer:
		debug.text += input + "\n"
