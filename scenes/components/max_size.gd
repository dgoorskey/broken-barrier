extends Container

@export var max_size := Vector2(INF, INF)

func fit_child() -> void:
	if get_child_count() == 0:
		return
	
	var position := Vector2.ZERO
	position.x = maxf(0.0, (size.x - max_size.x)/2.0)
	position.y = maxf(0.0, (size.y - max_size.y)/2.0)
	size.x = minf(size.x, max_size.x)
	size.y = minf(size.y, max_size.y)
	fit_child_in_rect(get_child(0), Rect2(position, size))
