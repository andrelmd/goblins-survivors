class_name HealthComponent extends Node

@export_category("Objects")
@export var actor: Actor

@export_category("Variables")
@export var max_health: float = 100

signal dead

var current_health: float:
	set(value):
		current_health = clamp(value, 0, max_health)
		if current_health == 0:
			dead.emit()
	get:
		return current_health

func _ready() -> void:
	current_health = max_health

func take_damage(attack: AttackData) -> void:
	current_health -= attack.damage
	if actor:
		actor.velocity = (actor.global_position - attack.knockback_position).normalized() * attack.knockback_force
