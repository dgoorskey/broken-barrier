#-------------------------------------------------------------------------------
# different screens (ie. title screen, options screen, gameplay screen).
# - There can be multiple.
#-------------------------------------------------------------------------------
extends Node
class_name Screen

func change_screen(screen: Screen) -> void:
	queue_free()
	get_parent().add_child(screen)
