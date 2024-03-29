#-------------------------------------------------------------------------------
# Area that can "hit" Hurtboxes
# - call `get_hurtboxes()` to get overlapping Hurtboxes
# - call `hit()` to attempt to hit the closest overlapping Hurtbox
#
# `movement` is used to determine the altitude.
# `flip2d` is used to determine knockback direction.
#-------------------------------------------------------------------------------
extends Area2D
class_name Hitbox

@export var movement: Movement2D = null # optional
@export var flip2d: Flip2D = null # optional

const INACTIVE_COLOR := Color8(255, 0, 0, 20)
const ACTIVE_COLOR := Color8(255, 0, 0, 255)
const VISIBLE_TIME := 10
var visible_time := 0

# returns a list of any overlapping Hurtboxes
func get_hurtboxes() -> Array[Hurtbox]:
	var results: Array[Hurtbox] = []
	for area in get_overlapping_areas():
		if area is Hurtbox:
			results.append(area)
	return results

# attempts to hit all overlapping Hurtboxes
func hit(damage=0, hitstun=0, knockback=Vector2.ZERO) -> void:
	visible_time = VISIBLE_TIME
	
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
		
		if movement != null:
			hitbox_altitude = movement.global_position.y
		
		if hurtbox.movement != null:
			hurtbox_altitude = hurtbox.movement.global_position.y
		
		# check if altitudes are close enough
		if hitbox_altitude < hurtbox_altitude - 30.0:
			return
		if hitbox_altitude > hurtbox_altitude + 30.0:
			return
		
		# determine knockback direction
		if flip2d != null:
			knockback.x *= flip2d.scale.x
		
		print('hit something!')
		hurtbox.hurt(damage, hitstun, knockback)

func _process(delta: float) -> void:
	if visible_time > 0:
		modulate = ACTIVE_COLOR
		visible_time -= 1
	else:
		modulate = INACTIVE_COLOR
