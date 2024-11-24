class_name Projectile extends Node2D

@export_category("Objects")
@export var projectile_data: ProjectileData

var direction: Vector2 = Vector2.ZERO

@onready var life_time: float = projectile_data.life_time


func _physics_process(delta: float) -> void:
	position += direction * projectile_data.speed * delta
	
	life_time -= delta

	if life_time <= 0:
		queue_free()
