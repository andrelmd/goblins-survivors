extends Node2D
class_name DamageEffect

@onready var label: Label = $Marker2D/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func set_damage_taken(amount: float):
	label.text = str(amount)
	

func _on_animation_player_animation_finished(_anim_name):
	queue_free()
