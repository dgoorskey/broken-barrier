#-------------------------------------------------------------------------------
# CollisionPolygon2D with an attached Polygon2D. Great for prototyping.
# - Edit the vertices of the CollisionPolygon2D.
# - Change update_shape in the editor to sync the vertices with the Polygon2D.
#-------------------------------------------------------------------------------
extends CollisionPolygon2D
@tool

# Instead of setting shape/color every frame, use setters and getters.
@export var update_shape := false:
	set(value):
		update_shape = false
		shape.polygon = polygon
		shape.color = color

@export var color := Color.BLACK

@onready var shape: Polygon2D = $Polygon2D
func _ready() -> void:
	shape.polygon = polygon
	shape.color = color
