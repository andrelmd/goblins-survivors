class_name Weapon extends Node2D

@export_category("Objects")
@export var weapon_data: WeaponData
@export var fire_rate_timer: Timer
@export var reload_timer: Timer

@onready var ammo: int = 0

var fire_direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	ammo = weapon_data.max_ammo

	fire_rate_timer.wait_time = weapon_data.fire_rate
	reload_timer.wait_time = weapon_data.reload_time

	fire_rate_timer.timeout.connect(_on_fire_rate_timer_timeout)
	reload_timer.timeout.connect(_on_reload_timer_timeout)

	fire_rate_timer.start()

func reload() -> void:
	fire_rate_timer.stop()

	if ammo < weapon_data.max_ammo:
		reload_timer.start()

func fire() -> void:
	if can_fire():
		ammo -= 1
		var projectile: Projectile = weapon_data.projectile.instantiate()
		get_tree().root.add_child(projectile)
		projectile.global_position = global_position
		projectile.direction = fire_direction
		projectile.rotation = fire_direction.angle()		
	else:
		reload()

func can_fire() -> bool:
	return ammo > 0

func _on_reload_timer_timeout() -> void:
	ammo = weapon_data.max_ammo
	fire_rate_timer.start()

func _on_fire_rate_timer_timeout() -> void:
	fire()
