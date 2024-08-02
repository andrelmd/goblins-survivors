extends Node2D

class_name AttackManager

@export var attacks: Dictionary = { }

func _ready():
	const ROTATING_ATTACK = preload("res://attacks/rotating_attack.tscn")
	var new_entity = ROTATING_ATTACK.instantiate()
	add_child(new_entity)
	attacks[new_entity] = true
