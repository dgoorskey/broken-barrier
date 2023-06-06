#-------------------------------------------------------------------------------
# Area that can be "hit" by Hitboxes
# - call `hurt()` to hit
#-------------------------------------------------------------------------------
extends Area2D
class_name Hurtbox

@export var root_position: Node2D = null # optional

signal hurt_signal

@onready var is_debug := get_tree().debug_collisions_hint
const INACTIVE_COLOR := Color8(0, 255, 0, 20)
const ACTIVE_COLOR := Color8(0, 255, 0, 255)
const VISIBLE_TIME := 10
var visible_time := 0

# enables the hitbox
func enable() -> void:
	monitorable = true

# disables the hitbox
func disable() -> void:
	monitorable = false

# do whatever needs to be done when hit
func hurt(damage=0, hitstun=0, knockback=Vector2.ZERO) -> void:
	hurt_signal.emit()
	print("OUCH!")
	
	visible_time = VISIBLE_TIME

func _process(delta: float) -> void:
	if not is_debug:
		return
	
	if visible_time > 0:
		modulate = ACTIVE_COLOR
		visible_time -= 1
	else:
		modulate = INACTIVE_COLOR
