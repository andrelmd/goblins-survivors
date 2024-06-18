extends CharacterBody2D

@onready var warrior_sprite = %WarriorSprite
@onready var hurt_box = %HurtBox
@onready var progress_bar = %ProgressBar

@export var speed: float
@export var damage_taken_rate: float = 5.0
@export var health: float = 100

signal health_depleted

func _ready():
	progress_bar.max_value = health
	progress_bar.value = health

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	play_animations()
	flip_sprite_h()
	move_and_slide()
	var overlapping_mobs = hurt_box.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= damage_taken_rate * overlapping_mobs.size() * delta
		progress_bar.value = maxf(0, health)
		if health <= 0:
			health_depleted.emit()

func play_animations():
		if not velocity.is_zero_approx():
			warrior_sprite.play_run_animation()
		else:
			warrior_sprite.play_idle_animation()

func flip_sprite_h():
	if velocity.x < 0:
		warrior_sprite.flip_h = true
	else:
		warrior_sprite.flip_h = false
