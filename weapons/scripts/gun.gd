class_name Gun extends Node2D

@export_category("Objects")
@export var bullet_scene: PackedScene
@export var weapon_data: GunData
@export var shooting_point: Marker2D
@export var fire_rate_timer: Timer
@export var fire_range_area: Area2D
@export var fire_range_collision_shape: CollisionShape2D

var target: Node2D = null

func _ready() -> void:
	fire_range_collision_shape.shape.radius = weapon_data.fire_range

	fire_rate_timer.wait_time = weapon_data.fire_rate
	fire_rate_timer.timeout.connect(_on_fire_rate_timer_timeout)
	fire_rate_timer.start()


func _physics_process(_delta: float) -> void:
	var enemies = fire_range_area.get_overlapping_bodies()
	if enemies.size() > 0:
		target = enemies[0]
	else:
		target = null

	if not target or not is_instance_valid(target):
		return
	
	look_at(target.global_position)
	
func fire() -> void:
	var bullet: Bullet = bullet_scene.instantiate()
	shooting_point.add_child(bullet)
	bullet.global_position = shooting_point.global_position
	bullet.global_rotation = shooting_point.global_rotation
	
func _on_fire_rate_timer_timeout() -> void:
	if target:
		fire()
