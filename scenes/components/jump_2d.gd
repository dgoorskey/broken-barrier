#-------------------------------------------------------------------------------
# jumping for Movement2D
# - From <https://www.youtube.com/watch?v=IOe1aGY6hXA>
# - Jumps preserve current velocity. You can overwrite velocity first if you
#   don't want that.
#-------------------------------------------------------------------------------
extends Node2D
class_name Jump2D

@export var movement: Movement2D

var jump_velocity := 0.0
var jump_gravity := 0.0
var fall_gravity := 0.0

func jump(height := 100, rise_time := 0.2, fall_time := 0.2) -> void:
	# Calculate some stuff. These stay until another jump overrides them.
	jump_velocity = ((2.0 * height) / rise_time)
#	jump_gravity = ((-2.0 * height) / (rise_time * rise_time))
#	fall_gravity = ((-2.0 * height) / (fall_time * fall_time))
	
	# Start the jump
	movement.add_velocity(Vector3.UP * jump_velocity)

#func _physics_process(delta: float) -> void:
	# Apply gravity
	# Using delta because these are accelerations.
#	if movement.velocity.y >= 0:
#		movement.add_velocity(Vector3.UP * jump_gravity * delta)
#	elif not movement.is_on_ground():
#		movement.add_velocity(Vector3.UP * fall_gravity * delta)
