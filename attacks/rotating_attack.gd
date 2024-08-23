extends Attack

class_name RotatingAttack

@export var attack: PackedScene
@export var attack_stats: AttackStats

@onready var cooldown_timer = $CooldownTimer
@onready var projectile_holder = $ProjectileHolder

func _ready():
	assert(attack, "Attack must exist in %s." % [str(get_path())])
	assert(attack_stats, "Attack stats must be exist in %s." % [str(get_path())])
	reload()
	cooldown_timer.timeout.connect(reload)
	cooldown_timer.wait_time = attack_stats.cooldown_time
	cooldown_timer.start()

func _process(delta):
	if attack_stats.ammo > 0:
		attack_stats.ammo -= 1
		create_projectile()
	rotation_degrees += 360 * delta * attack_stats.attack_speed

func reload():
	attack_stats.ammo = attack_stats.max_ammo - projectile_holder.get_child_count()
	cooldown_timer.start()

func create_projectile():
	var new_attack = attack.instantiate() as Projectile
	new_attack.scale = attack_stats.attack_size * new_attack.scale
	
	new_attack.connect("enemy_hit", Callable(self, "_on_enemy_hit"))
	get_tree().create_timer(attack_stats.duration).timeout.connect(new_attack.queue_free)
	
	projectile_holder.add_child(new_attack)
	var i = 1
	for child in projectile_holder.get_children():
		child.rotation_degrees = 360.0 / i
		i += 1
		
func _on_enemy_hit(area: HurtBoxComponent):
	area.get_hit(attack_stats.damage, attack_stats.knockback_amount, global_position.direction_to(area.global_position))
