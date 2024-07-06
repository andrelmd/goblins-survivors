extends Area2D

class_name HitBoxComponent

@export var damage: int = 0
@export var knockback_amount: int = 0

signal enemy_hit(attack_health_depleted_amount: int)

func call_enemy_hit(attack_health_depleted_amount: int):
	enemy_hit.emit(attack_health_depleted_amount)
