extends Sprite2D
class_name AlignedSprite2D
@tool

enum HorizontalAlignment {
	LEFT,
	CENTER,
	RIGHT
}

enum VerticalAlignment {
	TOP,
	MIDDLE,
	BOTTOM
}

@export var vertical_alignment := VerticalAlignment.MIDDLE:
	set(value):
		vertical_alignment = value
		update_position()

@export var horizontal_alignment := HorizontalAlignment.CENTER:
	set(value):
		horizontal_alignment = value
		update_position()

func _ready() -> void:
	update_position()

func update_position() -> void:
	centered = false
	
	var rect := get_rect()
	
	if horizontal_alignment == HorizontalAlignment.LEFT:
		position.x = 0
	elif horizontal_alignment == HorizontalAlignment.CENTER:
		position.x = -rect.size.x / 2 * scale.x
	elif horizontal_alignment == HorizontalAlignment.RIGHT:
		position.x = -rect.size.x * scale.x
	
	if vertical_alignment == VerticalAlignment.TOP:
		position.y = 0
	elif vertical_alignment == VerticalAlignment.MIDDLE:
		position.y = -rect.size.y / 2 * scale.y
	elif vertical_alignment == VerticalAlignment.BOTTOM:
		position.y = -rect.size.y * scale.y

