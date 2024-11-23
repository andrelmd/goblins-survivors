class_name Actor extends CharacterBody2D

@export_category("Objects")
@export var state_machine_component: StateMachine
@export var sprite: Sprite2D


func _ready() -> void:
	assert(state_machine_component != null, "Actor: state_machine_component not set")
	
func _process(delta: float) -> void:
	state_machine_component.update(delta)
	
	if not velocity.is_zero_approx():
		sprite.flip_h = velocity.x < 0

func _physics_process(delta: float) -> void:
	state_machine_component.update_physics(delta)
