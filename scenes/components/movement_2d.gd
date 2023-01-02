#-------------------------------------------------------------------------------
# component for controlling velocity (and maybe momentum?)
# - Should be a child of a CharacterBody2D.
# - Actual movement code (acceleration, jump, gravity) should be somewhere else.
#-------------------------------------------------------------------------------
extends Node2D
class_name Movement2D

@onready var parent: CharacterBody2D = get_parent()
#@export var optional_flip2d: Flip2D = null # Optional.

func _ready() -> void:
	# Don't get stuck on z axis.
	parent.floor_stop_on_slope = false
	
	# Don't slow down when sliding.
	parent.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func _physics_process(delta: float) -> void:
	# If we are on ground, don't move down.
	if is_on_ground() and velocity.y < 0.0:
		velocity.y = 0
	
	# CharacterController2D moves on x and z axis.
	parent.velocity.x = velocity.x
	parent.velocity.y = velocity.z
#	parent.move_and_collide(parent.velocity * delta)
	parent.move_and_slide()
	
	# Movement2D moves on y axis.
	position.y -= velocity.y * delta # Minus because positive y velocity is up.
	
	# If we are in the ground for some reason, move back up.
	position.y = minf(position.y, 0.0)
	
	# If a Flip2D is set, flip it the right way.
#	if optional_flip2d != null:
#		if velocity.x < 0.0:
#			optional_flip2d.face_left()
#		elif velocity.x > 0.0:
#			optional_flip2d.face_right()

@export var ground_height := 0.0
@export var velocity := Vector3.ZERO

func add_velocity(velocity: Vector3) -> void:
	self.velocity += velocity

func set_velocity(velocity: Vector3) -> void:
	self.velocity = velocity

func is_on_ground() -> bool:
	return -position.y <= ground_height

# Some utility functions for limiting speed
func limit_x_speed(max_speed: float) -> void:
	velocity.x = clampf(velocity.x, -max_speed, max_speed)
func limit_y_speed(max_speed: float) -> void:
	velocity.y = clampf(velocity.y, -max_speed, max_speed)
func limit_z_speed(max_speed: float) -> void:
	velocity.z = clampf(velocity.z, -max_speed, max_speed)
