#-------------------------------------------------------------------------------
# A Move that triggers a single hitbox whenever `hit()` is called (usually via
# an animation keyframe). It also applies hitstun and knockback.
#-------------------------------------------------------------------------------
extends Move

@export var hitbox: Hitbox = null # the hitbox to activate when this move starts. if null, uses the first child.

@export var damage := 0
@export var hitstun := 0
@export var knockback := Vector2.ZERO # +x is away from player, -x is towards.

func _ready() -> void:
	if hitbox == null and get_child(0) is Hitbox:
		hitbox = get_child(0)

# call this to activate the hitbox (usually called via an animation keyframe)
func hit() -> void:
	print(name + "!")
	hitbox.hit(damage, hitstun, knockback)
