#-------------------------------------------------------------------------------
# A Move that triggers a Hitbox as soon as a specific animation is entered.
#-------------------------------------------------------------------------------
extends Move

@export var animator: AnimationTree

@export var trigger_animation: StringName # the animation that will trigger this move
@export var hitbox: Hitbox = null # the hitbox to activate when this move starts. if null, uses the first child.

@export var damage := 0.0

func _ready() -> void:
	animator.animation_started.connect(on_animation_started)
	
	if hitbox == null and get_child(0) is Hitbox:
		hitbox = get_child(0)

func on_animation_started(animation: StringName) -> void:
	if trigger_animation != animation:
		return
	
	print(animation + "!")
	hitbox.hit()
