extends Area2D

class_name HurtBoxComponent

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtBoxType = 0
@export var invulnerability_window_seconds: float = 1
@export var health_component: HealthComponent
@export var knockback_component: KnockbackComponent

var hit_once_array: Array[Node] = []

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))

func _on_area_entered(area: Area2D):
	if not is_instance_of(area, HitBoxComponent) or not area.is_in_group("attack"):
		return
	match HurtBoxType:
		0: #Cooldown
			enable_invulnerability(true)
			start_invunerability_timer()
		1: #HitOnce
			clean_up_hit_once_array()
			if hit_once_array.has(area) == false:
				hit_once_array.append(area)
		#2: #DisableHitBox
			#if area.has_method("tempdisable"):
				#area.tempdisable()
	var damage = area.damage
	var knockback = 1
	
	if not area.get("knockback_amount") == null:
		knockback = area.knockback_amount
	if is_instance_valid(health_component):
		health_component.take_damage(damage)
	if is_instance_valid(knockback_component):
		knockback_component.take_knockback(knockback)
	if area.has_method("enemy_hit"):
		area.call_enemy_hit(1)

func _on_invulnerability_timeout():
	enable_invulnerability(false)
			
func enable_invulnerability(enable: bool = true):
	var children: Array[Node] = get_children()
	for child in children:
		if is_instance_of(child, CollisionShape2D):
			child.set_deferred("disabled", enable)
			

func start_invunerability_timer():
	get_tree().create_timer(invulnerability_window_seconds).timeout.connect(_on_invulnerability_timeout)

func clean_up_hit_once_array():
	for node in hit_once_array:
		if not is_instance_valid(node):
			hit_once_array.erase(node)
