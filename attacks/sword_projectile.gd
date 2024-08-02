extends Projectile

class_name SwordProjectile

var attack_component: Attack

func _ready():
	attack_component = get_parent() as Attack
	assert(attack_component, "Projectile must be a child of a Attack node in %s." % [str(get_path())])

func _on_hit_box_component_area_entered(area: Area2D):
	if is_instance_of(area, HurtBoxComponent):
		enemy_hit.emit(area)
	
