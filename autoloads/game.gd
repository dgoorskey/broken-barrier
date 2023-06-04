extends Node

var frame := 0
func _physics_process(delta: float) -> void:
	frame += 1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
