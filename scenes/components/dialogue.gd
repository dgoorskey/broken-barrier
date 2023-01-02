extends Node
class_name Dialogue

class DialogueLine:
	var source := ""
	var text := ""

var dialogue_lines: Array[DialogueLine] = []

@export_file("*.json") var json_file
func _ready() -> void:
	var file := FileAccess.open(json_file, FileAccess.READ)
	var file_text := file.get_as_text(true)
	var data: Variant = JSON.parse_string(file_text)
	print(data)
	
#	assert(data is Array)
#	for line_data in data:
#		assert(line_data is Dictionary)
#		var source: String = line_data.get("source", null)
#		var text: String = line_data.get("line", "unknown")
#		var dialogue_line := DialogueLine.new()
#		dialogue_line.source = source
#		dialogue_line.text = text
#		dialogue_lines.append(dialogue_line)
#
#	for l in dialogue_lines:
#		print_line(l)
#
#func print_line(line: DialogueLine) -> void:
#	print("[%s] %s" % [line.source, line.text])
#
#func get_next() -> DialogueLine:
#	return dialogue_lines.pop_front() # Returns null if empty.

func start() -> void:
	print("STARTING DIALOGUE")
	pass
