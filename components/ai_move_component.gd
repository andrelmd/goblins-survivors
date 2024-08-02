extends Node

class_name AiMoveComponent


@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

@export var move_component: MoveComponent

func _ready():
	assert(move_component, "AiMoveComponent must be a child of a MoveComponent node in %s." % [str(get_path())])
	
func _physics_process(_delta):
		move_component.direction = move_component.character_node.global_position.direction_to(player.global_position)

