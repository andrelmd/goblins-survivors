class_name IdlePlayerState extends PlayerState


func enter_state():
	move_component.direction = Vector2.ZERO
	animation_player.play("idle")

func update(_delta: float, data: StateData):
	if data.new_state != "Idle":
		state_changed.emit(data.new_state)
		return
