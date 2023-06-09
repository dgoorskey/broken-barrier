extends CharacterBody2D

@export var movement: Movement2D
@export var jump: Jump2D
@export var interactor: Interactor
@export var input_buffer: InputBuffer
@export var animator: AnimationTree

@onready var flip2d_1: Flip2D = $Flip2D
@onready var flip2d_2: Flip2D = $Movement2D/Flip2D

func _ready() -> void:
	$AnimationTree.active = true

func _physics_process(delta: float) -> void:
	
	handle_moves()
	
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
			movement.add_velocity(Vector3.FORWARD * z_movement * 10000 * delta) # forward is (0, 0, -1)
			movement.limit_z_speed(500)
		
		if Input.is_action_just_pressed("p1_jump"):
			jump.jump(200, 0.35, 0.25)
	
	if Input.is_action_just_pressed("p1_a"):
		interactor.interact()

@onready var state_machine: AnimationNodeStateMachinePlayback = animator["parameters/playback"]
func handle_moves() -> void:
	var current_move := state_machine.get_current_node()
	
	# Punch
	if current_move == "idle" and input_buffer.starts_with(input_buffer.buffer, ["a"]):
		input_buffer.consume()
		state_machine.travel("punch")
	
	# Kick
	if current_move == "idle" and input_buffer.starts_with(input_buffer.buffer, ["b"]):
		input_buffer.consume()
		state_machine.travel("kick")
	
#	$DebugUI/Label.text = $AnimationPlayer.current_animation
	$DebugUI/Label.text = state_machine.get_current_node()
