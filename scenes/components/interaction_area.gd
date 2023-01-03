#-------------------------------------------------------------------------------
# area to be interacted with
# - Doesn't do anything by itself. Other nodes can listen to the signals.
# - Call interact() to interact.
# - hover() is usually called when an Interactor overlaps this, but hasn't
#   actually interacted. Useful for interaction prompts.
#-------------------------------------------------------------------------------
extends Area2D
class_name InteractionArea

signal interacting
signal hovering

func interact() -> void:
	interacting.emit()

func hover() -> void:
	hovering.emit()
