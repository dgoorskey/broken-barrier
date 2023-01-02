extends Node
class_name InteractionDialogue

@export var interaction_area: InteractionArea

func _ready() -> void:
	interaction_area.interacting.connect(_on_interacting)

func _on_interacting() -> void:
	pass
