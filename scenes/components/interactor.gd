#-------------------------------------------------------------------------------
# area for interacting with other things
# - Call interact() to interact with the closest InteractionArea.
# - Calls hover() on the closest InteractionArea each frame.
#-------------------------------------------------------------------------------
extends Area2D
class_name Interactor

func interact() -> void:
#	for area in get_overlapping_areas():
#		if area is InteractionArea:
#			area.interact()
#			return
	var closest := get_closest_interaction_area()
	if closest != null:
		closest.interact()

func _physics_process(delta: float) -> void:
	
	# Make the closest interaction area show info ("hover")
	var closest := get_closest_interaction_area()
	if closest != null:
		closest.hover()
	
	# TODO: For efficiency, only check this if the player has actually moved.

func get_closest_interaction_area() -> InteractionArea:
	var closest: InteractionArea = null
	var closest_distance := 0.0
	
	for area in get_overlapping_areas():
		if area is InteractionArea:
			# Get closest one
			var distance := global_position.distance_to(area.global_position)
			if distance < closest_distance or closest == null:
				closest = area
				closest_distance = distance
	
	return closest
