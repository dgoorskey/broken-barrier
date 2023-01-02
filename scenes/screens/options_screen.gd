extends Screen

@onready var TITLE_SCREEN := load("res://scenes/screens/title_screen.tscn")
func _on_cancel_pressed() -> void:
	var screen: Screen = TITLE_SCREEN.instantiate()
	change_screen(screen)

func _on_apply_pressed() -> void:
	var screen: Screen = TITLE_SCREEN.instantiate()
	change_screen(screen)
