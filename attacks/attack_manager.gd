extends Node2D

class_name AttackManager

@export var attacks: Array[PackedScene] = []
	
func add_attack(attack: PackedScene):
	var new_attack = attack.instantiate() as Attack
	add_child(new_attack)
