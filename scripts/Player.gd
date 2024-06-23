class_name Player
extends CharacterBody2D

@onready var warrior_sprite: WarriorSprite = %WarriorSprite
@onready var health_component: HealthComponent = $HealthComponent
@onready var inventory_component: InventoryComponent = $InventoryComponent
@onready var attack_projectile_component: AttackProjectileComponent = $AttackProjectileComponent

@export var health_items: Array[Item] = []
@export var speed: float
@export var level: int = 0

signal health_depleted
signal health_changed(health_left: int)

var direction: Vector2 = Vector2.ZERO
var dead: bool = false


func _physics_process(_delta):
	if dead: return
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = direction * speed
	play_animations()
	flip_sprite_h()
	move_and_slide()

func play_animations():
		if not velocity.is_zero_approx():
			warrior_sprite.play_run_animation()
		else:
			warrior_sprite.play_idle_animation()

func flip_sprite_h():
	if direction != Vector2.ZERO:
		if direction.x < 0:
			warrior_sprite.flip_h = true
		else:
			warrior_sprite.flip_h = false


func _on_health_component_damage_taken(health_left: float, _amount: float):
	health_changed.emit(health_left)


func _on_health_component_health_depleted():
	dead = true
	await warrior_sprite._play_death_animation()
	health_depleted.emit()


func _on_inventory_component_inventory_item_changed(item_type: Item, quantity: int):
	if health_items.has(item_type):
		health_component.recover_health(quantity)
		inventory_component.remove_item(item_type, quantity)


func _on_health_component_health_recovered(health_left: float):
	health_changed.emit(health_left)
	
func level_up(growth_rate: float):
	level += 1
	var effect = preload("res://effects/level_up_effect.tscn").instantiate()
	add_child(effect)
	#health_component.max_health = max(health_component.max_health, health_component.max_health * growth_rate)
	health_component.recover_health(health_component.max_health)
	attack_projectile_component.set_damage(attack_projectile_component.get_damage() * (1 + growth_rate))
