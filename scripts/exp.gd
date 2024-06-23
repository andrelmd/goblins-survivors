class_name ItemResource
extends Node2D

@export var resource: ItemResource

var type: String = 'exp'
var quantity: int = 10

func _ready():
	print('estou pronto')

func _on_pickup_area_area_entered(area):
	if area.has_method('pick_up'):
		area.pick_up(resource)
		queue_free()
