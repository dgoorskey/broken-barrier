#-------------------------------------------------------------------------------
# flips left or right
# - Uses scale.x
# - Keep scale at default value or weird stuff might happen!
#-------------------------------------------------------------------------------
extends Node2D
class_name Flip2D

func face_left() -> void:
	scale.x = -1

func face_right() -> void:
	scale.x = 1

func flip() -> void:
	scale.x *= -1
