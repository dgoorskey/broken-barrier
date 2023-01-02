extends CollisionPolygon2D
@tool

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
