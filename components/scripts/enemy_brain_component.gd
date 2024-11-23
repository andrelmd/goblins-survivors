class_name EnemyBrainComponent extends BrainComponent

@export_category("Objects")
@export var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func get_inputs() -> StateData:
	var inputs = StateData.new()
	inputs.new_state = "Idle"
	
	var move_direction = Vector2.ZERO
	var distance_to_player = 0

	if player:
		move_direction = player.global_position - owner.global_position
		distance_to_player = move_direction.length()
		move_direction = move_direction.normalized()

	if distance_to_player < 100:
		inputs.new_state = "Attack"
		inputs.move_direction = move_direction
	else:
		inputs.new_state = "Run"
		inputs.move_direction = move_direction

	return inputs
