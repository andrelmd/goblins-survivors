class_name RunPlayerState extends PlayerState

func enter_state():
	move_component.direction = Vector2.ZERO
	animation_player.play("running")

func update_physics(_delta: float, data: StateData):
	if data.new_state != "Run":
		state_changed.emit(data.new_state)
		return

	move_component.direction = data.move_direction
