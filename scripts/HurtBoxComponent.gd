extends Area2D
class_name HurtBoxComponent

@export var health_component: HealthComponent

func take_damage(amount: float):
	if health_component:
		health_component.take_damage(amount)
