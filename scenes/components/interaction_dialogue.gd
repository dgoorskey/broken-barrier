extends Node
class_name InteractionDialogue

@export_file("*.json") var json_file
@export var interaction_area: InteractionArea
@export var dialogue_screen: DialogueScreen

func _ready() -> void:
	interaction_area.interacting.connect(_on_interacting)

@onready var level: Level = get_tree().get_first_node_in_group("level")
func _on_interacting() -> void:
	dialogue_screen.load_json(json_file)
	dialogue_screen.start()
