extends Area2D

@export var current_level: Level
#@export var level_scene: PackedScene # circular reference here causes silent crashing :(

# must export a string path to avoid cyclic dependency issues, and must
# dynamically load it when needed.
@export_file("*.tscn") var level_scene_path

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var level_scene: PackedScene = load(level_scene_path)
		var level := level_scene.instantiate()
		current_level.change_level(level)
