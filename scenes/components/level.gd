#-------------------------------------------------------------------------------
# gameplay levels
# - There should only be 1 at any time.
# - Get the current one with `get_tree().get_first_node_in_group("level")`
#-------------------------------------------------------------------------------
extends Node2D
class_name Level

func _ready() -> void:
	add_to_group("level")
	process_mode = Node.PROCESS_MODE_PAUSABLE

func change_level(level: Level) -> void:
	queue_free()
	get_parent().add_child(level)
