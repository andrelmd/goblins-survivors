class_name PlayerBrainComponent extends BrainComponent

func get_inputs() -> StateData:
	var inputs = StateData.new()
	inputs.new_state = "Idle"
	
	var move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if not move_direction.is_zero_approx():
		inputs.new_state = "Run"
		inputs.move_direction = move_direction


	return inputs
