extends Node2D


@onready var mob_spawner_follow_path: PathFollow2D = %MobSpawnerFollowPath
@onready var tile_map: TileMap = %TileMap
@onready var game_over_screen = %GameOverScreen
@onready var player: Player = $Player
@onready var hud = $HUD
@onready var stats: Stats = $HUD/Stats
@onready var timer = $Player/MobSpawner/Timer
@onready var watch = $HUD/Timer

@export var mobs: Array[PackedScene]
@export var mob_chances: Array[float]
@export var mobs_per_minute: float = 30
@export var difficult_rate: float = 0.05
@export var max_mobs: int = 200


var time_passed: float = 0.0	

func _ready():
	stats.health_bar.max_value = player.health_component.max_health
	stats.health_bar.value = player.health_component.max_health
	assert(mobs.size() == mob_chances.size(), "The size of mobs array and mob_chances array must be the same.")

func spawn_mob():
	mob_spawner_follow_path.progress_ratio = randf()
	var coordinate = mob_spawner_follow_path.global_position
	var tile_position = tile_map.local_to_map(coordinate)
	var tile_data = tile_map.get_cell_tile_data(1, tile_position)
	
	if tile_data:
		var can_spawn_mob = tile_data.get_custom_data('can_spawn_mobs')
		if not can_spawn_mob:
			return
		
	var mob_index = get_random_mob_index()
	var new_mob = mobs[mob_index].instantiate()
	new_mob.global_position = coordinate
	new_mob.connect('health_depleted', self._on_goblin_death)
	add_child(new_mob)
	new_mob.set_max_health(max(new_mob.get_max_health(), new_mob.get_max_health() * time_passed * difficult_rate))
	new_mob.gold_value = max(new_mob.gold_value, new_mob.gold_value * time_passed * difficult_rate)
	new_mob.exp_value = max(new_mob.exp_value, new_mob.exp_value * time_passed * difficult_rate)

func get_random_mob_index() -> int:
	var total_chance = 0.0
	for chance in mob_chances:
		total_chance += chance

	var random_value = randf() * total_chance
	var cumulative_chance = 0.0

	for i in range(mob_chances.size()):
		cumulative_chance += mob_chances[i]
		if random_value < cumulative_chance:
			return i

	return mob_chances.size() - 1  # Caso ocorra algum erro de arredondamento

func _on_timer_timeout():
	time_passed += timer.wait_time
	var minutes = int(time_passed / 60.0)
	var seconds = int(time_passed) % 60
	var time_text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
	watch.text = time_text
	var spawned_mobs = get_tree().get_nodes_in_group('enemy').size()
	if max_mobs <= spawned_mobs: return
	var mobs_to_spawn = max(int(mobs_per_minute/ 60 * difficult_rate * time_passed),1)
	for i in range(mobs_to_spawn):
		spawn_mob()

func _on_player_health_depleted():
	get_tree().paused = true
	game_over_screen.show()
	hud.hide()


func _on_button_pressed():
	get_tree().paused = false
	hud.show()
	get_tree().reload_current_scene()
	
func _on_goblin_death(gold_value: int, exp_value: int):
	stats.increase_gold_counter(gold_value)
	stats.increase_exp_bar(exp_value)
	if stats.get_exp_value() >= stats.get_exp_max_value():
		stats.set_exp_max_value(stats.get_exp_max_value() * (1 + player.level))
		stats.update_exp_bar(1)
		player.level_up(difficult_rate * time_passed * 0.2 )

func _on_player_health_changed(health_left):
	stats.update_health_bar(health_left)
