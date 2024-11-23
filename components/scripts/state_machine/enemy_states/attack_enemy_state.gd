class_name AttackEnemyState extends EnemyState

var attack_finished = false

func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_player_animation_finished.unbind(1))

func enter_state() -> void:
	move_component.direction = Vector2.ZERO
	animation_player.stop()
	animation_player.play("attacking")

func update_physics(_delta: float, data: StateData) -> void:
	if data.new_state != "Attack" and attack_finished:
		state_changed.emit(data.new_state)
		return

	if attack_finished:
		state_changed.emit("Idle")

func exit_state() -> void:
	attack_finished = false

func _on_animation_player_animation_finished() -> void:
	attack_finished = true
