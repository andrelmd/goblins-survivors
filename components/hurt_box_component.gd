extends Area2D

class_name HurtBoxComponent

@export var health_component: HealthComponent
@export var knockback_component: KnockbackComponent

#func _ready():
	#connect("area_entered", Callable(self, "_on_area_entered"))

func get_hit(damage_amount: float, knockback_amount: float, knockback_direction: Vector2):
	if knockback_component:
		knockback_component.take_knockback(knockback_amount, knockback_direction)
