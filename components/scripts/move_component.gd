class_name MoveComponent extends Node

@export_category("Variables")
@export var speed: float = 100.0
@export var direction: Vector2 = Vector2.ZERO

@export_category("Objects")
@export var actor: CharacterBody2D

func _ready() -> void:
	assert(actor, "MoveComponent: actor is null")

func _physics_process(_delta: float) -> void:
	actor.velocity = direction * speed
	actor.move_and_slide()
