#-------------------------------------------------------------------------------
# This represents something a character can do. Usually, an animation (ie. for
# an attack) calls a function on an inherited version of this scene.
# - an easier way is probably to extend this script, instead of extending the
#   entire scene.
#-------------------------------------------------------------------------------
extends Node2D
class_name Move

@export var animator: AnimationTree

func _ready() -> void:
	animator.animation_started.connect(on_animation_started)
	animator.animation_finished.connect(on_animation_finished)

# Called when an animation starts. Inherited scenes should override this.
func on_animation_started(animation: StringName) -> void:
	pass

# Called when an animation ends. Inherited scenes should override this.
func on_animation_finished(animation: StringName) -> void:
	pass
