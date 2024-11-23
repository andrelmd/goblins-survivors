class_name RunEnemyState extends EnemyState

func enter_state() -> void:
	animation_player.play("running")

func update_physics(_delta: float, data: StateData) -> void:
	if data.new_state != "Run":
		state_changed.emit(data.new_state)
		return

	move_component.direction = data.move_direction
