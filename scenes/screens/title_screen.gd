extends Screen

@onready var GAMEPLAY_SCREEN := load("res://scenes/screens/gameplay_screen.tscn")
func _on_play_pressed() -> void:
	var screen: Screen = GAMEPLAY_SCREEN.instantiate()
	change_screen(screen)

@onready var OPTIONS_SCREEN := load("res://scenes/screens/options_screen.tscn")
func _on_settings_pressed() -> void:
	var screen: Screen = OPTIONS_SCREEN.instantiate()
	change_screen(screen)
