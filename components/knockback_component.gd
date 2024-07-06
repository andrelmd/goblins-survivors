extends Node

class_name KnockbackComponent

@export var knockback_recovery: float

@onready var player = get_tree().get_first_node_in_group("player")

var move_component: MoveComponent
var knockback: Vector2 = Vector2.ZERO

func _ready():
	move_component = get_parent() as MoveComponent
	assert(move_component, "KnockbackComponent must be a child of a MoveComponent node in %s." % [str(get_path())])

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	
func take_knockback(knockback_amount: float):
	move_component.can_move = false
	knockback += player.global_position.direction_to(move_component.actor.global_position) * knockback_amount
