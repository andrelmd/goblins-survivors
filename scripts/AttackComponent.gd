extends Area2D
class_name AttackComponent

@export var damage: float = 1
@export var is_damage_over_time: bool = false
@export var disabled: bool = false
@export var attack: Node2D

func _process(_delta):
	if attack and attack.has_method('get_damage'):
		damage = attack.get_damage()

func _physics_process(delta: float):
	if disabled:
		return
	if is_damage_over_time:
		_do_damage_over_time(delta)

func _do_damage_over_time(delta: float):
	var parent_groups = get_parent().get_groups()
	var overlapping_areas = get_overlapping_areas()
	for area in overlapping_areas:
		if not area.has_method('take_damage'):
			continue
		var area_parents_groups = area.get_parent().get_groups()
		var has_same_group: bool = false
		for group in area_parents_groups:
			if parent_groups.has(group):
				has_same_group = true
		if not has_same_group:
			area.take_damage(damage * delta)


func _on_area_entered(area):
	if is_damage_over_time or disabled or not area is HurtBoxComponent:
		return
	var parent_groups = get_parent().get_groups()
	var area_parents_groups = area.get_parent().get_groups()
	var has_same_group: bool = false
	for group in area_parents_groups:
		if parent_groups.has(group):
			has_same_group = true
			break
	if not has_same_group:
		area.take_damage(damage)
