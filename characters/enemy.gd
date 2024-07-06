extends CharacterBody2D
@onready var health_component: = %HealthComponent as HealthComponent

func _ready():
	health_component.health_depleted.connect(Callable(self, "_on_health_depleted"))

func _on_health_depleted():
	queue_free()
