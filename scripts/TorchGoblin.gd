extends CharacterBody2D

@onready var torch_goblin_sprite = %TorchGoblinSprite
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurt_box_component: Area2D = $HurtBoxComponent
@onready var attack_component: Area2D = $AttackComponent

@export var speed: float  
@export var drop_table: Array[PackedScene]
@export var drop_table_chances: Array[float] = [0.2]
@export var gold_value: int = 10
@export var exp_value: int = 1

var direction: Vector2 = Vector2.ZERO
var player: CharacterBody2D
var dead: bool = false

signal health_depleted(gold_value: int)

func _ready():
	player = get_tree().get_first_node_in_group('player')
	

func _physics_process(_delta):
	if dead: return
	direction = global_position.direction_to(player.global_position).normalized()
	velocity = direction * speed 
	play_animations()
	flip_sprite_h()
	move_and_slide()

func play_animations():
	if not velocity.is_zero_approx():
		torch_goblin_sprite.play_run_animation()
	else:
		torch_goblin_sprite.play_idle_animation()

func flip_sprite_h():
	if direction != Vector2.ZERO:
		if direction.x < 0:
			torch_goblin_sprite.flip_h = true
		else:
			torch_goblin_sprite.flip_h = false

func _on_health_component_health_depleted():
	dead = true
	self.collision_layer = 0
	self.collision_mask = 0
	await torch_goblin_sprite.play_death_animation()
	health_depleted.emit(gold_value, exp_value)
	var drop_chance = randf()
	if drop_chance <= 0.05:
		var new_drop = drop_table[0].instantiate()
		add_sibling(new_drop)
		new_drop.global_position = global_position
	queue_free()

func set_max_health(amount: float):
	if health_component:
		health_component.max_health = amount
		health_component.health = amount

func get_max_health():
	if health_component:
		return health_component.max_health


func _on_health_component_damage_taken(_health_left, damage):
	var effect: DamageEffect = preload("res://effects/damage_effect.tscn").instantiate()
	add_child(effect)
	effect.set_damage_taken(damage)
