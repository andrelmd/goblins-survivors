extends CharacterBody2D

@export var attacks: Array[PackedScene] = []

@onready var health_bar: ProgressBar = $HealthBar
@onready var health_component: HealthComponent = $HealthComponent
@onready var attack_manager = $AttackManager

func _ready():
	health_component.health_changed.connect(update_health_bar)
	for attack in attacks:
		attack_manager.add_attack(attack)

func update_health_bar(amount: int):
	health_bar.value = amount

func add_attack(attack: PackedScene):
	attacks.append(attack)
	attack_manager.add_attack(attack)

func remove_attack(attack: PackedScene):
	attacks.erase(attack)
	attack_manager.remove_attack(attack)
