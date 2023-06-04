#-------------------------------------------------------------------------------
# Area that can "hit" Hurtboxes
# - call `get_hurtboxes()` to get overlapping Hurtboxes
# - call `hit()` to attempt to hit the closest overlapping Hurtbox
#-------------------------------------------------------------------------------
extends Area2D
class_name Hitbox

@export var root_position: Node2D = null # optional

# returns a list of any overlapping Hurtboxes
func get_hurtboxes() -> Array[Hurtbox]:
	var results: Array[Hurtbox] = []
	for area in get_overlapping_areas():
		if area is Hurtbox:
			results.append(area)
	return results

# attempts to hit all overlapping Hurtboxes
func hit() -> void:
	for hurtbox in get_overlapping_areas():
		if not hurtbox is Hurtbox:
			continue
		
		#-----------------------------------------------------------------------
		# Hitboxes/Hurtboxes can be linked to Movement2Ds. We need to check if
		# the "vertical axis" for both are close enough to count as a collision.
		# There are 4 cases:
		# 1. neither have a Movement2D
		# 2. Hitbox has Movement2D, Hurtbox doesn't
		# 3. Hitbox doesn't have any Movement2D, Hurtbox does
		# 4. Both have a Movement2D
		#-----------------------------------------------------------------------
		
		var hitbox_altitude := 0.0
		var hurtbox_altitude := 0.0
		
		if root_position != null:
			hitbox_altitude = root_position.global_position.y
		
		if hurtbox.root_position != null:
			hurtbox_altitude = hurtbox.root_position.global_position.y
		
		# check if altitudes are close enough
		if hitbox_altitude < hurtbox_altitude - 30.0:
			return
		if hitbox_altitude > hurtbox_altitude + 30.0:
			return
		
		print('hit something!')
		hurtbox.hurt()
