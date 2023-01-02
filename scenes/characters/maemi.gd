extends CharacterBody2D

@export var movement: Movement2D
@export var jump: Jump2D
@export var interactor: Interactor

@onready var flip2d_1: Flip2D = $Flip2D
@onready var flip2d_2: Flip2D = $Movement2D/Flip2D

func _physics_process(delta: float) -> void:
	
	if movement.is_on_ground():
		
		# Check for x movement
		var x_movement := 0.0
		if Input.is_action_pressed("p1_left"):
			x_movement -= 1
			flip2d_1.face_left()
			flip2d_2.face_left()
		if Input.is_action_pressed("p1_right"):
			x_movement += 1
			flip2d_1.face_right()
			flip2d_2.face_right()
		
		# Accelerate or decelerate on x axis
		if x_movement == 0:
			movement.limit_x_speed(0)
		else:
			movement.add_velocity(Vector3.RIGHT * x_movement * 10000 * delta)
			movement.limit_x_speed(500)
		
		# Check for z movement
		var z_movement := 0.0
		if Input.is_action_pressed("p1_up"):
			z_movement += 1
		if Input.is_action_pressed("p1_down"):
			z_movement -= 1
		
		# Accelerate or decelerate on z axis
		if z_movement == 0:
			movement.limit_z_speed(0)
		else:
			movement.add_velocity(Vector3.FORWARD * z_movement * 10000 * delta)
			movement.limit_z_speed(500)
		
		if Input.is_action_just_pressed("p1_jump"):
			jump.jump(200, 0.35, 0.25)
	
	if Input.is_action_just_pressed("p1_a"):
		interactor.interact()
