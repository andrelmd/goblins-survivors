extends Node

class_name KnockbackComponent

@export var knockback_recovery: float

@onready var player = get_tree().get_first_node_in_group("player")

@export var move_component: MoveComponent
var knockback: Vector2 = Vector2.ZERO

func _ready():
	assert(move_component, "KnockbackComponent must be a child of a MoveComponent node in %s." % [str(get_path())])

func _physics_process(_delta: float):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	move_component.direction += knockback
	
func take_knockback(knockback_amount:float, knockback_direction: Vector2):
	knockback = knockback_direction * knockback_amount
	print("Taken ", knockback, " knockback")
