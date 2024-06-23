extends Area2D
class_name AttackProjectileComponent
@export var spawner: SpawnComponent
@export var damage: float = 5

func _on_timer_timeout():
	var bodies: Array[Node2D] = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group('enemy'):
			look_at(body.global_position)
			if spawner:
				spawner.spawn()
			return

func set_damage(amount: float):
	damage = snapped(amount, 0.01)

func get_damage():
	return damage
