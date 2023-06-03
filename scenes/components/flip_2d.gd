#-------------------------------------------------------------------------------
# flips left or right
# - Uses scale.x
# - Keep scale at default value or weird stuff might happen!
#-------------------------------------------------------------------------------
extends Node2D
class_name Flip2D

signal flipped_left
signal flipped_right

func face_left() -> void:
	scale.x = -1
	flipped_left.emit()

func face_right() -> void:
	scale.x = 1
	flipped_right.emit()

func flip() -> void:
	scale.x *= -1
	if scale.x < 0:
		flipped_left.emit()
	else:
		flipped_right.emit()
