#-------------------------------------------------------------------------------
# Area that can be "hit" by Hitboxes
# - call `hurt()` to hit
#-------------------------------------------------------------------------------
extends Area2D
class_name Hurtbox

@export var movement: Movement2D = null # optional

signal hurt_signal

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
	
	# apply knockback
	if knockback != Vector2.ZERO and movement != null:
		movement.set_velocity(Vector3(knockback.x, knockback.y, 0.0))

func _process(delta: float) -> void:
	if visible_time > 0:
		modulate = ACTIVE_COLOR
		visible_time -= 1
	else:
		modulate = INACTIVE_COLOR
