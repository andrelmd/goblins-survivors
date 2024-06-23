extends Node2D
class_name SpawnComponent

@export var entity: PackedScene
@export var attack_projectile_component: AttackProjectileComponent

func spawn():
	if entity:
		var new_entity = entity.instantiate()
		get_parent().add_child(new_entity)
		new_entity.global_position = global_position
		new_entity.global_rotation = global_rotation
		if new_entity.has_method('set_damage'):
			new_entity.set_damage(attack_projectile_component.damage)
