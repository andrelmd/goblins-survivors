class_name DaggerAttack extends Attack

@export var attack_stats: AttackStats
@export var projectile: PackedScene

@onready var cooldown_timer = $CooldownTimer
@onready var projectile_holder = $ProjectileHolder
@onready var target_range = $Range
@onready var range_collision_shape = $Range/CollisionShape2D

func _ready():
	assert(attack_stats, "Attack stats must exist in %s." % [str(get_path())])
	cooldown_timer.wait_time = attack_stats.cooldown_time
	cooldown_timer.connect("timeout", Callable(self, "_reload"))
	cooldown_timer.start()
	range_collision_shape.shape.radius = attack_stats.speed * attack_stats.duration

func _process(_delta: float):
	if attack_stats.ammo > 0:
		attack_stats.ammo -= 1
		var target = select_target()
		if target != null:
			create_projectile(target)
	for attack in projectile_holder.get_children():
		attack.global_position += attack_stats.speed * Vector2.RIGHT.rotated(attack.rotation)

func create_projectile(enemy):
	launch_attack(enemy)

func _reload():
	attack_stats.ammo = attack_stats.max_ammo
	cooldown_timer.start()

func _on_enemy_hit(hurtbox: HurtBoxComponent, projectile_reference: Projectile):
	hurtbox.get_hit(attack_stats.damage, attack_stats.knockback_amount, global_position.direction_to(hurtbox.global_position))
	projectile_reference.queue_free()

func launch_attack(target: Enemy):
	if target != null:
		var projectile_instance = projectile.instantiate() as Projectile
		var direction = global_position.direction_to(target.global_position)
		projectile_instance.rotation = direction.angle()
		projectile_instance.connect("enemy_hit", Callable(self, "_on_enemy_hit"))
		get_tree().create_timer(attack_stats.duration).timeout.connect(projectile_instance.queue_free)
		projectile_holder.add_child(projectile_instance)

func select_target():
	var enemies = target_range.get_overlapping_bodies()
	var closest_enemy = null
	var closest_distance = INF
	var max_distance = attack_stats.speed * attack_stats.duration
	var current_position = global_position

	for enemy in enemies:
		var distance = current_position.distance_to(enemy.global_position)
		if distance < max_distance and distance < closest_distance:
			closest_enemy = enemy
			closest_distance = distance

	return closest_enemy
