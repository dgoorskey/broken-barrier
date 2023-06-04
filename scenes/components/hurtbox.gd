#-------------------------------------------------------------------------------
# Area that can be "hit" by Hitboxes
# - call `hurt()` to hit
#-------------------------------------------------------------------------------
extends Area2D
class_name Hurtbox

@export var root_position: Node2D = null # optional

signal hurt_signal

# enables the hitbox
func enable() -> void:
	monitorable = true

# disables the hitbox
func disable() -> void:
	monitorable = false

# do whatever needs to be done when hit
func hurt() -> void:
	hurt_signal.emit()
	print("OUCH!")
