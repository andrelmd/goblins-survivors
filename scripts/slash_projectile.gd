extends AttackProjectile

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(global_rotation)
	var travel_speed = delta * speed
	
	global_position += travel_speed * direction
	distance_traveled += travel_speed
	if distance_traveled >= max_distance:
		queue_free()


func _on_slash_damage_area_body_entered(body):
	if body.has_method('take_damage'):
		body.take_damage(damage)
