class_name Bullet extends Node2D

@export_category("Objects")
@export var hitbox_component: HitBoxComponent

@export_category("Variables")
@export var speed: float = 100
@export var damage: int = 10
@export var travel_range: float = 1000.0
@export var knockback_force: float = 0

@onready var travelled_distance: float = 0



func _ready() -> void:
	top_level = true
	hitbox_component.area_entered.connect(_on_hitbox_component_area_entered)

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

	travelled_distance += speed * delta

	if travelled_distance > travel_range:
		queue_free()

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	print(area)
	if area is HurtBoxComponent:
		var attack = AttackData.new()
		attack.damage = damage
		attack.knockback_force = knockback_force
		attack.knockback_position = global_position
		area.take_damage(attack)

	queue_free()
