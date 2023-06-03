#-------------------------------------------------------------------------------
# z-sorts children based on the state of a Flip2D
# - no change when facing right
# - inverted when facing left
# - will change the order of children
#-------------------------------------------------------------------------------
extends Node2D
class_name FlipSort2D

@export var flip_2d: Flip2D

func _ready() -> void:
	flip_2d.flipped_left.connect(flip_sort)
	flip_2d.flipped_right.connect(flip_sort)

# flips the order of all children
func flip_sort() -> void:
	for child in get_children():
		move_child(child, -1)
