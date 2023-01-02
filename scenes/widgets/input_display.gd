extends HBoxContainer

@onready var a: Label = $A
@onready var b: Label = $B
@onready var up: Label = $GridContainer/Up
@onready var down: Label = $GridContainer/Down
@onready var left: Label = $GridContainer/Left
@onready var right: Label = $GridContainer/Right
@onready var jump: Label = $GridContainer/Jump

func _process(delta: float) -> void:
	if Input.is_action_pressed("p1_a"):
		show_input(a)
	else:
		hide_input(a)
	
	if Input.is_action_pressed("p1_b"):
		show_input(b)
	else:
		hide_input(b)
	
	if Input.is_action_pressed("p1_left"):
		show_input(left)
	else:
		hide_input(left)
		
	if Input.is_action_pressed("p1_right"):
		show_input(right)
	else:
		hide_input(right)
	
	if Input.is_action_pressed("p1_up"):
		show_input(up)
	else:
		hide_input(up)
	
	if Input.is_action_pressed("p1_down"):
		show_input(down)
	else:
		hide_input(down)
	
	if Input.is_action_pressed("p1_jump"):
		show_input(jump)
	else:
		hide_input(jump)

func show_input(label: Label) -> void:
	label.modulate = Color.WHITE

func hide_input(label: Label) -> void:
	label.modulate = Color8(50, 50, 50, 255)
