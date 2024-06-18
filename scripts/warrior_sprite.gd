extends Sprite2D

@onready var animation_player = %AnimationPlayer

func play_run_animation():
	animation_player.play("run")
	
func play_idle_animation():
	animation_player.play("idle")
