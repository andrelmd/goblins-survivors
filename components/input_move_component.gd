extends Node

class_name InputMoveComponent

var _move_component: MoveComponent

func _ready():
	_move_component = get_parent() as MoveComponent
	assert(_move_component, "InputMoveComponent must be a child of a MoveComponent node in %s." % [str(get_path())])

func _process(_delta):
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	_move_component.direction = direction
