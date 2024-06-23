class_name HealthComponent
extends Node

@export var max_health: float = 100
var health: float:
	set(amount):
		health = amount
		
		if health <= 0:
			health = 0
			health_depleted.emit()
		if health > max_health:
			health = max_health

signal health_depleted
signal damage_taken(health_left: float, damage: float)
signal health_recovered(health_left:float)

func _ready():
	health = max_health

func take_damage(amount: float):
	health -= amount
	damage_taken.emit(health, amount)
	
func recover_health(amount: float):
	health += amount
	health_recovered.emit(health)
