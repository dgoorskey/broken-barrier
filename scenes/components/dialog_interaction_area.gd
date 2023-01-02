extends Area2D
class_name DialogueInteractionArea

@export var dialogue: Dialogue
func interact() -> void:
	dialogue.start()
