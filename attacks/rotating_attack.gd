extends Node2D

class_name Attack

@export var attack: PackedScene
@export var attack_stats: AttackStats

func _ready():
	assert(attack, "Attack must be exist in %s." % [str(get_path())])
	assert(attack_stats, "Attack stats must be exist in %s." % [str(get_path())])
	reload()

func _process(delta):
	if attack_stats.ammo > 0:
		attack_stats.ammo -= 1
		create_projectile()
	rotation_degrees += 360 * delta * attack_stats.attack_speed

func reload():
	attack_stats.ammo = attack_stats.max_ammo - get_child_count()

func create_projectile():
	var new_attack = attack.instantiate() as Projectile
	new_attack.scale = attack_stats.attack_size * Vector2.ONE
	new_attack.connect("enemy_hit", Callable(self, "_on_enemy_hit"))
	add_child(new_attack)
	var i = 1
	for child in get_children():
		child.rotation_degrees = 360.0 / i
		i += 1
		
func _on_enemy_hit(area: HurtBoxComponent):
	print("hitted ", area, " with ", attack_stats.damage, " damage")
	area.get_hit(attack_stats.damage, attack_stats.knockback_amount, global_position.direction_to(area.global_position))
	
	
