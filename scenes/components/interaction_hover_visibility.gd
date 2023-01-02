#-------------------------------------------------------------------------------
# visible only when an InteractionArea is hovered
# - Put things like interaction prompts as children of this.
#-------------------------------------------------------------------------------
extends Node2D
class_name InteractionHoverVisibility

@export var interaction_area: InteractionArea

func _on_hovering() -> void:
	visible = true

func _physics_process(delta: float) -> void:
	visible = false

func _ready() -> void:
	interaction_area.hovering.connect(_on_hovering)
