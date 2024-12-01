class_name Enemy extends Actor

@export_category("Objects")
@export var hitbox_component: HitBoxComponent
@export var health_component: HealthComponent
@export var player: Player

func _ready() -> void:
	assert(health_component, "Enemy: health_component is null")
	health_component.dead.connect(_on_health_component_dead)
	
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	super(delta)
	
	if not hitbox_component:
		return

	hitbox_component.look_at(player.global_position)


func _on_health_component_dead() -> void:
	queue_free()
