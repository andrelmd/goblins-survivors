class_name IdleEnemyState extends EnemyState

func enter_state() -> void:
	move_component.direction = Vector2.ZERO
	animation_player.play("idle")

func update_physics(_delta: float, data: StateData) -> void:
	if data.new_state != "idle":
		state_changed.emit(data.new_state)
		return
