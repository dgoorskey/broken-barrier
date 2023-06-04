#-------------------------------------------------------------------------------
# A Move that triggers a Hitbox as soon as a specific animation is entered.
#-------------------------------------------------------------------------------
extends Move

@export var trigger_animation: StringName # the animation that will trigger this move
@export var hitbox: Hitbox # the hitbox to activate when this move starts

@export var damage := 0.0
@export var knockback := 0.0

func on_animation_started(animation: StringName) -> void:
	if trigger_animation != animation:
		return
	
	print(animation + "!")
	hitbox.hit()
