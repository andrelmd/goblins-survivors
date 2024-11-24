class_name WeaponHolsterComponent extends Node2D

@export_category("Objects")
@export var pivot: Marker2D
@export var initial_weapons: Array[PackedScene] = []

var weapons: Array[Weapon] = []
var mouse_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	for weapon_scene in initial_weapons:
		var weapon: Weapon = weapon_scene.instantiate()
		add_child(weapon)
		add_weapon(weapon)
		weapon.global_position = pivot.global_position

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pivot.look_at(get_global_mouse_position())
		mouse_direction = pivot.global_position.direction_to(get_global_mouse_position())
		for weapon in weapons:
			weapon.fire_direction = mouse_direction
		

func add_weapon(weapon: Weapon) -> void:
	weapons.append(weapon)

func remove_weapon(weapon: Weapon) -> void:
	weapons.erase(weapon)

