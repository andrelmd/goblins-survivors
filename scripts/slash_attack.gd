extends Area2D

@export var slash_sprite: PackedScene

func _on_timer_timeout():
	var enemies = get_overlapping_bodies()
	if enemies.size() > 0:
		var enemy = enemies.front()
		look_at(enemy.global_position)
		var slash_entity = slash_sprite.instantiate()
		slash_entity.global_position = global_position
		slash_entity.rotation = rotation
		add_child(slash_entity)
