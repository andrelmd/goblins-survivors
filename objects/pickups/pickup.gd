extends Node

@export var resource_type: Item
@export var quantity: int

@onready var animation_player: AnimationPlayer = self.get_node('AnimationPlayer') as AnimationPlayer

func _ready():
	if animation_player:
		animation_player.play('spawn')

func _on_body_entered(body: CharacterBody2D):
	var inventory = body.find_child('InventoryComponent')
	if inventory:
		inventory.add_item(resource_type, quantity)
		queue_free()
		
