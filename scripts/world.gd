extends Node2D


@onready var mob_spawner_follow_path: PathFollow2D = %MobSpawnerFollowPath
@onready var tile_map: TileMap = %TileMap
@onready var canvas_layer = %CanvasLayer

@export var mob: PackedScene

func spawn_mob():
	mob_spawner_follow_path.progress_ratio = randf()
	var coordinate = mob_spawner_follow_path.global_position
	var tile_position = tile_map.local_to_map(coordinate)
	var tile_data = tile_map.get_cell_tile_data(0, tile_position)
	if tile_data:
		var can_spawn_mob = tile_data.get_custom_data('can_spawn_mobs')
		if not can_spawn_mob:
			return
		var new_mob = mob.instantiate()
		new_mob.global_position = coordinate
		add_child(new_mob)

func _on_timer_timeout():
	spawn_mob()


func _on_player_health_depleted():
	get_tree().paused = true
	canvas_layer.show()


func _on_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
