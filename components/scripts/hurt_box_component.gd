class_name HurtBoxComponent extends Area2D

@export_category("Objects")
@export var health_component: HealthComponent

func take_damage(attack: AttackData) -> void:
	health_component.take_damage(attack)