class_name WarriorSprite
extends Sprite2D

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func play_run_animation():
	animation_player.play("run")
	
func play_idle_animation():
	animation_player.play("idle")

func _play_death_animation():
	animation_player.play("death")
	return await animation_player.animation_finished
