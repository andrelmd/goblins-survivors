extends Node2D

class_name AttackManager

@export var attack: PackedScene
@export var attack_stats: AttackStats

@onready var attack_timer = %AttackTimer
@onready var reload_timer = %ReloadTimer
@onready var entity_holder = %EntityHolder

func _ready():
	attack_timer.wait_time = attack_stats.attack_speed
	reload_timer.wait_time = attack_stats.reload_speed
	reload_timer.start()


func _on_reload_timer_timeout():
	match attack_stats.type:
		0: # Projectile
			attack_stats.ammo = attack_stats.max_ammo
		1: # Entity
			attack_stats.ammo = attack_stats.max_ammo - entity_holder.get_child_count()
	attack_timer.start()


func _on_attack_timer_timeout():
	create_new_attack()
	match attack_stats.type:
		0:
			if attack_stats.ammo > 0:
				attack_timer.start()
			else:
				attack_timer.stop()
		1:
			attack_timer.start()

func create_new_attack():
	if attack_stats.ammo > 0:
		var attack_instance: = attack.instantiate() as Attack
		attack_instance.attack_stats = attack_stats
		entity_holder.call_deferred("add_child", attack_instance)
		attack_stats.ammo -= 1
