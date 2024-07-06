extends Node

class_name  HealthComponent

@export var max_health: int

signal health_depleted
signal damage_taken(amount: int)

var health: int :
	set(amount):
		health = clamp(amount, 0, max_health)
		if health == 0:
			health_depleted.emit()

func _ready():
	health = max_health

func take_damage(amount: int):
	health -= amount
	damage_taken.emit(amount)
