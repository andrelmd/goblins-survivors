class_name State extends Node

signal state_changed(new_state: String)

func enter_state():
	pass

func exit_state():
	pass

func update(_delta: float, _data: StateData):
	pass

func update_physics(_delta: float, _data: StateData):
	pass
