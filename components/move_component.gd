extends Node

class_name MoveComponent

const DECELERATION_TARGET_VELOCITY := Vector2.ZERO

@export_range(0.0, 1000.0, 0.01, "or_greater", "hide_slider") var max_speed := 64.0

@export_range(0.0, 1.0) var acceleration_coefficient := 1.0

@export_range(0.0, 1.0) var deceleration_coefficient := 1.0

var direction := Vector2.ZERO

var character_node: CharacterBody2D

func _ready():
	character_node = get_parent() as CharacterBody2D
	assert(character_node, "VelocityComponent must be a child of a CharacterBody2D node in %s." % [str(get_path())])

func _physics_process(_delta: float) -> void:
	if direction.is_zero_approx():
		if character_node.velocity:
			_decelerate()
	else:
		_accelerate()

	character_node.move_and_slide()

func _accelerate() -> void:
	var acceleration_rate := max_speed * acceleration_coefficient
	var speed = direction.normalized() * max_speed
	character_node.velocity = character_node.velocity.move_toward(speed, acceleration_rate)

func _decelerate() -> void:
	var deceleration_rate := max_speed * deceleration_coefficient
	character_node.velocity = character_node.velocity.move_toward(DECELERATION_TARGET_VELOCITY, deceleration_rate)
