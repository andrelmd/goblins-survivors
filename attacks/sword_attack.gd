extends Attack

class_name SwordAttack

@onready var sword_collision = %SwordCollision
@onready var hit_box_component: = %HitBoxComponent as HitBoxComponent

func _ready():
	hit_box_component.set_deferred("damage", attack_stats.damage)
	hit_box_component.set_deferred("knockback_amount", attack_stats.knockback_amount)
	var final_scale = scale * attack_stats.attack_size
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", final_scale, 0.25).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()

func _process(delta: float):
	var rotation_diference = 360 * delta * attack_stats.attack_speed
	rotation_degrees += rotation_diference
