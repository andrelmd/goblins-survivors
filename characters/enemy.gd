extends CharacterBody2D

class_name Enemy

@export var max_health: int
@export var damage: int

@onready var health_component := %HealthComponent as HealthComponent

func _ready():
	health_component.health_depleted.connect(Callable(self, "_on_health_depleted"))

func _on_health_depleted():
	queue_free()

func _on_hit_box_component_area_entered(area: HurtBoxComponent):
	if (is_instance_of(area, HurtBoxComponent)):
		area.get_hit(damage, 0, Vector2(0, 0))
