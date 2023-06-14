extends CharacterBody2D

@export var movement: Movement2D

func _physics_process(delta: float) -> void:
	if movement.is_on_ground():
		movement.limit_x_speed(0.0)

