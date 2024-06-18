extends CharacterBody2D

@onready var torch_goblin_sprite = %TorchGoblinSprite
@onready var player = get_node("/root/World/Player")

@export var speed: float  
@export var health: float = 100
@export var drop_table: Array[PackedScene]

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
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
	if velocity.x < 0:
		torch_goblin_sprite.flip_h = true
	else:
		torch_goblin_sprite.flip_h = false

func take_damage(damage):
	health -= damage
	if health <= 0: 
		queue_free()

func _on_hurt_box_damage_taken(damage):
	take_damage(damage)
