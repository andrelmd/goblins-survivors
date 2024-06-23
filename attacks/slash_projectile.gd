extends Node2D

@export var max_distance: float
@export var speed: float
@export var damage: float = 5

var distance: float :
	set(new_distance):
		distance = new_distance
		
		if distance > max_distance:
			queue_free()

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(global_rotation).normalized()
	var velocity = speed * delta
	global_position += velocity * direction
	distance += velocity 

func set_damage(amount: float):
	damage = amount

func get_damage():
	return damage
