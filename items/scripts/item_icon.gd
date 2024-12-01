@tool
class_name ItemIcon extends Sprite2D

enum ICON_NAMES {
	IRON_RING_WITHOUT_GEM = 0,
	SPEAR = 96,
	BOW = 128
}

const icon_rotation_degrees = {
	ICON_NAMES.IRON_RING_WITHOUT_GEM: 0,
	ICON_NAMES.SPEAR: 45,
	ICON_NAMES.BOW: 45
}

@export_category("Variables")
@export var icon_name: ICON_NAMES = ICON_NAMES.SPEAR

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		frame = icon_name
		rotation_degrees = icon_rotation_degrees[icon_name]
