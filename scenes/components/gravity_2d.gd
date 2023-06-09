extends Node2D

@export var movement: Movement2D

@export var up_gravity := -3333.0 # gravity applied when moving up
@export var down_gravity := -6400.0 # gravity applied when moving down

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if movement.velocity.y >= 0.0:
		movement.add_velocity(Vector3.UP * up_gravity * delta)
	else:
		movement.add_velocity(Vector3.UP * down_gravity * delta)
