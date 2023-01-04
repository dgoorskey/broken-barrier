extends PanelContainer
class_name DialogueOption

signal pressed

@export var first_button: DialogueOption

@onready var border: NinePatchRect = $NinePatchRect
@onready var label: RichTextLabel = $MarginContainer/RichTextLabel

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("p1_a"):
		if has_focus():
			press()
	elif Input.is_action_just_pressed("p1_b"):
		if has_focus():
			# Go to next button:
			var next: Control = get_node(focus_next)
			if is_instance_valid(next) and next.visible:
				next.grab_focus.call_deferred()
			elif is_instance_valid(first_button) and first_button.visible:
				first_button.grab_focus.call_deferred()

func press() -> void:
	print(name + " was pressed")
	pressed.emit()

func set_text(text: String) -> void:
	if text == "":
		visible = false
	else:
		visible = true
		label.clear()
		label.append_text(text)


func _on_focus_entered() -> void:
	border.visible = true

func _on_focus_exited() -> void:
	border.visible = false
