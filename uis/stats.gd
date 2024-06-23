extends Control
class_name Stats
@onready var health_bar: ProgressBar =$Banner/HealthBar
@onready var gold_counter: Label = $Banner/GoldCounter
@onready var exp_bar: ProgressBar = $Banner/ExpBar

func _ready():
	gold_counter.text = str(0)
	
func update_health_bar(amount: float):
	health_bar.value = amount

func increase_gold_counter(amount: int):
	gold_counter.text = str(int(gold_counter.text) + amount)

func update_exp_bar(amount: float):
	exp_bar.value = amount

func increase_exp_bar(amount: float):
	exp_bar.value += amount

func get_exp_value():
	return exp_bar.value

func get_exp_max_value():
	return exp_bar.max_value

func set_exp_max_value(amount:float):
	exp_bar.max_value = amount
