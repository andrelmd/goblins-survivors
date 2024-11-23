class_name StateMachine extends Node

@export_category("Objects")
@export var initial_state: State
@export var brain_component: BrainComponent

@onready var current_state: State = (func get_initial_state() -> State:
		return initial_state if initial_state != null else get_child(0)
).call()

var states: Dictionary = {}

func _ready() -> void:
	if not current_state:
		printerr("StateMachine: No initial state set")

	for child in get_children():
		if child is State:
			child.state_changed.connect(_on_state_changed)
			states[child.name.to_lower()] = child

	current_state.enter_state()

func update(delta: float) -> void:
	var inputs = brain_component.get_inputs()
	current_state.update(delta, inputs)

func update_physics(delta: float) -> void:
	var inputs = brain_component.get_inputs()
	current_state.update_physics(delta, inputs)

func _on_state_changed(new_state: String) -> void:
	var state_node = states[new_state.to_lower()]

	if not state_node:
		printerr("StateMachine: State not found: " + new_state)
		return

	current_state.exit_state()
	current_state = state_node
	current_state.enter_state()
