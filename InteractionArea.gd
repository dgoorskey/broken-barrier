extends Area2D
class_name InteractionArea

signal interacting
signal hovering

func interact() -> void:
	interacting.emit()

func hover() -> void:
	hovering.emit()
