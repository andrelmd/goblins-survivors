extends Projectile

class_name SwordProjectile

func _on_hit_box_component_area_entered(area: Area2D):
	if is_instance_of(area, HurtBoxComponent):
		enemy_hit.emit(area, self)
	
