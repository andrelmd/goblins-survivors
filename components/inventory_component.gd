extends Node
class_name InventoryComponent

@export var inventory: Dictionary = {}

signal inventory_item_changed(item_type: Item, quantity: int)

func add_item(item_type: Item, quantity: int):
	if inventory.has(item_type):
		inventory[item_type] += quantity
	else:
		inventory[item_type] = quantity
	inventory_item_changed.emit(item_type, quantity)

func remove_item(item_type: Item, quantity: int):
	if inventory.has(item_type):
		inventory[item_type] -= quantity
