#-------------------------------------------------------------------------------
# z-sorts children based on the state of a Flip2D
# - no change when facing right
# - inverted when facing left
# - will set `z_as_relative` to true on children
# - will modify `z_index` of children
#-------------------------------------------------------------------------------
extends Node2D
class_name FlipSort2D

@export var flip_2d: Flip2D

func _ready() -> void:
	flip_2d.flipped_left.connect(sort_left)
	flip_2d.flipped_right.connect(sort_right)

# z-sorts children as if the Flip2D is facing right
func sort_right() -> void:
	var z := 0
	var children := get_children()
	children.reverse() # last child should have highest z-index
	for child in children:
		if child is CanvasItem:
			child = child as CanvasItem
			child.z_as_relative = true
			child.z_index = z
		z -= 1

# z-sorts children as if the Flip2D is facing left
func sort_left() -> void:
	var z := 0
	var children := get_children()
#	children.reverse()
	for child in children:
		if child is CanvasItem:
			child = child as CanvasItem
			child.z_as_relative = true
			child.z_index = z
		z -= 1
