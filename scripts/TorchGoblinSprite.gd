extends Sprite2D

@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var health: int

func play_run_animation():
	animation_player.play("run")
	
func play_idle_animation():
	animation_player.play("idle")

func play_death_animation():
	animation_player.play("death")
	await animation_player.animation_finished
