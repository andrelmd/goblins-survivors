extends Sprite2D

var max_distance = 200
var distance = 0.0
var speed = 1000.0

@export var damage = 50

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position = global_position + direction * delta * speed
	
	distance += delta * speed
	
	if distance >= max_distance:
		queue_free()


func _on_area_2d_area_entered(area):
	if area.has_method("take_damage"):
		area.take_damage(damage)
