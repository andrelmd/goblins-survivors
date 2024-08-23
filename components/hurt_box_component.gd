extends Area2D

class_name HurtBoxComponent

@export var health_component: HealthComponent
@export var knockback_component: KnockbackComponent

func get_hit(damage_amount: int, knockback_amount: float, knockback_direction: Vector2):
	if health_component:
		health_component.take_damage(damage_amount)
	if knockback_component:
		knockback_component.take_knockback(knockback_amount, knockback_direction)
